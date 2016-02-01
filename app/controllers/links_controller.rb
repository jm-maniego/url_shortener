class LinksController < ApplicationController
  before_action :set_link, only: [:show, :index, :newly_created]
  before_action :set_page, only: [:index, :newly_created, :create]
  before_action :set_new_links, only: [:newly_created, :create]

  def index
    @top_links = Link.order('clicks DESC').paginate(page: @page, per_page: 10)
  end

  def newly_created
  end

  # GET /links/1
  # GET /links/1.json
  def show
    if params[:slug] && params[:controller] != params[:slug]
      if @link.present? && redirect_to(@link.given_url)
        @link.clicks += 1
        @link.save!
      end
    elsif params[:id]
      @link = Link.find(params[:id])
    end
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to newly_created_links_path, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :newly_created }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      # wanted to use find_or_initialize by but it will instantiate with values
      @link = Link.find_by(slug: params[:slug]) || Link.new
    end

    def set_page
      @page = params[:page] || 1
    end

    def set_new_links
      @new_links = Link.order('created_at DESC').paginate(page: @page, per_page: 10)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:given_url)
    end
end

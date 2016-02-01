class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  def index
    @link  = Link.new
    page   = params[:page] || 1
    @links = Link.order('clicks DESC').paginate(page: page, per_page: 10)
  end

  # GET /links/1
  # GET /links/1.json
  def show
    if params[:slug]
      if @link.present? && redirect_to(@link.given_url)
        @link.clicks += 1
        @link.save!
      end
    elsif params[:id]

    end
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to root_path, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:given_url)
    end
end

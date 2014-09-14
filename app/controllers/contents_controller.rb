class ContentsController < ApplicationController
  def index
  	@contents = Content.all.to_a
  end

  def new
  	@content = Content.new
  end

  def create
  	@content = Content.create(content_params)
  	redirect_to contents_path
  end

  def update
  	@content = Content.find_by(id: params[:content][:id])
  	@content.update_attributes(content_params)
  end

	private

	def content_params
	  params.require(:content).permit(:name, :post, :post_time)
	end

end

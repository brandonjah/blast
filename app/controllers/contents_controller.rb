class ContentsController < ApplicationController
  def index
  	@contents = Content.all.to_a
    @tweet = Tweet.new
  end

  def landing_page
    @tweet = Tweet.new
    if params[:landing_page]
      @landing_page = params[:landing_page]
      @content = Content.find_by(name: params[:landing_page])
      if @content.nil? 
        @landing_page = "default"
        @content = Content.find_by(name: @landing_page)
      end
    else
      flash[:alert] = "Didn't find content"
      @content = Content.new
    end
    render layout: "landing_page"
  end

  def new
  	@content = Content.new
  end

  def create
  	@content = Content.new(content_params)
    if @content.save
      respond_to do |format|
         format.html {redirect_to contents_path}
      end
    end
  end

  def update
  	@content = Content.find_by(id: params[:content][:id])
  	@content.update_attributes(content_params)
  end

   def destroy
    content = Content.find(params[:id])
    content.destroy
    respond_to do |format|
       format.html {redirect_to contents_path}
    end    
   end  

	private

	def content_params
	  params.require(:content).permit(:name, :post, :post_time)
	end

end
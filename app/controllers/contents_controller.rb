class ContentsController < ApplicationController
  def index
  	@contents = Content.all.to_a
    @tweet = Tweet.new
  end

  def landing_page
    @tweet = Tweet.new
    current_user ? @show_modal = true : @show_modal = false
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
    @schedule_tweet_title = @content.name || "blast.social"
    @schedule_tweet_post = @tweet.message || "Welcome to blast.social!"
    @schedule_tweet_post_time = @content.pretty_date || ""
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
    else
      flash[:error] = "Failed Validation"
      respond_to do |format|
         format.html {redirect_to new_content_path}
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
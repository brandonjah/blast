class ContentsController < ApplicationController
  def index
  	@contents = Content.all.to_a
    @tweet = Tweet.new
  end

  def landing_page
    @tweet = Tweet.new
    current_user || current_facebook_user ? @show_modal = true : @show_modal = false
    if params[:landing_page]
      @landing_page = params[:landing_page]
      @content = Content.find_by(name: params[:landing_page])
      if @content.blank? 
        @landing_page, params[:landing_page] = "default"
        @content = Content.find_by(name: @landing_page)
      end
    else
      flash[:alert] = "Didn't find content"
      @content = Content.new
    end
    @schedule_tweet_title = @content.name || "blast.social"
    @schedule_tweet_post = @tweet.message || "Welcome to blast.social!"
    @schedule_tweet_post_time = @content.pretty_date || ""
    # @graph = Koala::Facebook::API.new('CAACEdEose0cBANO0VFbVNgWMZCTuvC2zMXnBftNweZCHnM95vr3zBXiGNsLnUdAuECCbSKsRROXSV4iiBbl37XlnuQ72fIxhH9vZAXcxfv5B8isDLlsu0Ti9ih7631kaVsxoWWtecL3ofEa5ZAQgvPoAiP6WYsW6pbLALFYAaMwSl41wZACgZBTdzvDsPAipws4hkbvFnZBHJyqLmgGKZCZCFZBRSBaua7cfwZD')
    render layout: "landing_page"
  end

  def new
  	@content = Content.new
  end

  def create
    Time.zone = content_params[:time_zone]
  	@content = Content.new(content_params)
    # @content.post_time = Time.zone.parse(@content.post_time.to_s).utc.in_time_zone(content_params[:time_zone])
    @content.post_time = @content.post_time.in_time_zone("Pacific Time (US & Canada)")

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
    content.destroy!
    respond_to do |format|
       format.html {redirect_to contents_path}
    end    
  end  

	private

	def content_params
	  params.require(:content).permit(:name, :post, :post_time, :message_prompt, :time_zone)
	end
end
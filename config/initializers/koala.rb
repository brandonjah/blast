Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise "application id and/or secret are not specified in the envrionment" unless ENV['BLAST_FACEBOOK_KEY'] && ENV['BLAST_FACEBOOK_SECRET']
    initialize_without_default_settings(ENV['BLAST_FACEBOOK_KEY'].to_s, ENV['BLAST_FACEBOOK_SECRET'].to_s, args.first)
  end 

  alias_method_chain :initialize, :default_settings 
end
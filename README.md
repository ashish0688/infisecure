# Infisecure

Welcome to Infisecure gem! This gem will call the infisecure server with give parameters.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'infisecure', git: 'git@github.com:satish-zol/infisecure.git', branch: 'master'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install infisecure

## Usage

	rails g infisecure:install

The generator prompts for the following details to create infisecure_config.rb:

    1. Server name - It lists down the available infisecure servers. Please choose the server closest to your region by selecting the option.

    2. Sid - Enter the Subscriber Id available in your infisecure account.

    3. Secret Key - Enter the secret key available in your infisecure account.

Once the above options are entered infisecure_config.rb will be created inside config/initializers folder.

add below code in application_controller.rb

	before_action :call_infisecure

In call_infisecure method add below code, required parameter to pass in current_user_id, request, cookies
	
	@infisecure = Infisecure.api(current_user.id, request, cookies)

	if @infisecure["statusCode"] == 1000
		logger.debug "allow the user request"		
	elsif @infisecure["statusCode"] == 1001
		logger.debug "throw captcha to the user"
  	elsif @infisecure["statusCode"] == 1002
  		logger.debug "feed fake data for his request"
  	elsif @infisecure["statusCode"] == 1003
  		logger.debug "kill the request or redirect to error page"
	elsif @infisecure["statusCode"] == 1005
  		logger.debug "monitor the bad requests don't block"
 	elsif @infisecure["statusCode"] == -1
  		logger.debug "Please reach out to infisecure support team for assistance <BR>"
  		logger.debug "Allow the user request"      
	end	

add the below code before body tag end in your layout file e.g. application.html.erb

	<script type="text/javascript">	
		var lnisj1 = new Infisecure('<%= @infisecure["upid"] %>');
	</script>
	<script async = "true" type="text/javascript" src="http://www.infisecure.com/assets/js/infisecure.js"></script>
	

	//= require infisecure
	
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/satish-zol/infisecure. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


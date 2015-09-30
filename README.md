# leisuredeals

This Project is a [Xapix.io](http://www.xapix.io) demo Project. Watch it live at [www.leisuredeals.net](http://www.leisuredeals.net).

It's Rails 4.2 and uses [xapix_client](https://github.com/pickledolives/xapix_client) as the only backend connetion (no DB). If you wonder why there is a DB config still, it's because Heroku requires a database, so we had to setup a FREE one.

Without access to our XapiX.io project you won't be able to run this out of the box, but feel free to use it as a blue print.

## Interesting files

```ruby
# config/initializers/xapix.rb

XapixClient.configure do |config|
  config.project_name = ENV['XAPIX_PROJECT_NAME']
  config.auth_token = ENV['XAPIX_AUTH_TOKEN']
end
```

```ruby
# app/models/local_deal.rb

# On XapiX.io we created on project 'leisuredeals' an Output Endpoint 'local_deals'.
# It is backed by meanwhile stale Groupon data of an affiliate network

class LocalDeal < XapixClient::Resource
end
```

```ruby
# app/controllers/deal_categories_controller.rb

class DealCategoriesController < ApplicationController

  def index
    @deals = LocalDeal.order(:score).page(1).per(15)
  end

  #...
end
```

## Setup

We run this on Heroku. Locally (UNIX systems) provide environment variables

```
export XAPIX_PROJECT_NAME=your_xapix_project_name
export XAPIX_AUTH_TOKEN=your_xapix_auth_token
```

On server additionally

```
export NEW_RELIC_KEY=your_new_relic_key
export AIRBRAKE_API_KEY=your_airbrake_key
```

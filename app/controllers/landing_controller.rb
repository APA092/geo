class LandingController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
  end
  
  def decode
    request_line = URI::encode "http://geocoder.api.here.com/6.2/geocode.json?app_id=sT4evJ6zERUorlOM0NMU&app_code=ZoLn3Vjmf4jFUe-kQ3t6xQ&searchtext=" + location_params[:address]
    url = URI.parse(request_line)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    hash = JSON.parse(res.body)
    render :json => hash
  end
  
  private
    def location_params
      params.require(:landing).permit(:address)
    end
end

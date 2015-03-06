Chewy.strategy(:urgent)
Chewy.logger = Rails.logger
Chewy.settings = { prefix: "#{ Rails.env }", host: 'localhost:9250' }

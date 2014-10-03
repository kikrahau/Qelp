FactoryGirl.define do
  factory :user do

  	factory :user1 do
    	email 'ethel@factorygirl.com'
      name 'Ethel'
    	password 'f4k3p455w0rd'
    end

  	factory :user2 do
    	email 'vinc@factoryboy.com'
      name 'Vinc'
    	password '12345678'
  	end

  	factory :user3 do
  		email 'vincent@factoryboy.com'
      name 'Vincent'
    	password '12345678'
  	end
  end
end
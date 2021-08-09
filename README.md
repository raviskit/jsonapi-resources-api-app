# JSONAPI Resource Sample app

## System Configuration
 * Ruby 2.6
 * Rails 6.1
 * PostgreSQL
 * RSpec
 
## Steps to run the app


1. clone the repo in your local and cd into the local directory.
 
	  ```
	  git clone https://github.com/raviskit/jsonapi-resources-api-app.git
	  cd jsonapi-resources-api-app
	  ``` 
  
2. Run bundle by running `bundle install` 
3. Create db and run migration by running `rails db:setup db:migrate db:seed`
4. Run the server `rails s`
5. Alternatively, App is dockerized as well.

## API Endpoints

### Course
#### GET _Index_

	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/courses

#### GET _Show_

	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/courses/:id

### POST _Create_

	curl -H 'content-type: application/vnd.api+json' -d '{ "data":{ "type":"courses", "attributes":{ "name":"course1" }, "relationships":{ "coach":{ "data":{ "type":"coaches", "id":"1" } } } } }' -X POST http://localhost:3000/api/v1/courses
 
#### DELETE _Destroy_

	curl -H 'content-type: application/vnd.api+json' -X DELETE http://localhost:3000/api/v1/courses/:id

#### Filter with Self Assignable

	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/courses?filter%5Bself_assignable%5D=false


### Coach

####GET _Index_

	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/coaches

#### GET _Show_
   
	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/coaches/:id

### POST _Create_

	curl -H 'content-type: application/vnd.api+json' -d '{ "data":{ "type":"coaches", "attributes":{ "name":"coach1" } } }' -X POST http://localhost:3000/api/v1/coaches

#### DELETE _Destroy_
	curl -H 'content-type: application/vnd.api+json' -X DELETE http://localhost:3000/api/v1/coaches/:id


### Activity

####GET _Index_

	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/activities

#### GET _Show_
   
	curl -H 'content-type: application/vnd.api+json' -X GET http://localhost:3000/api/v1/activities/:id

#### POST _Create_
	curl -H 'content-type: application/vnd.api+json' -d '{ "data":{ "type":"activities", "attributes":{ "name":"activity1" }, "relationships":{ "course":{ "data":{ "type":"courses", "id":"1" } } } } }' -X POST http://localhost:3000/api/v1/activities

#### DELETE _Destroy_
	curl -H 'content-type: application/vnd.api+json' -X DELETE http://localhost:3000/api/v1/activities/:id


## Specs
To run the specs, run `rspec spec`
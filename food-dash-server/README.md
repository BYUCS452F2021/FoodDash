# FoodDash Server Application

## Package Structure

* Domain layer code, including model objects and data access should be in `edu.byu.cs452.fooddash.domain`
* Service layer code, AKA business logic code should be in `edu.byu.cs452.fooddash.service`
* Web layer code, including controllers, and configuration for the web app should be in `edu.byu.cs452.fooddash.web`

## Run and Debug Server Locally

### Run Maven on project

You need Maven installed on your machine to run tests prior to making your pull requests. You also need to have Maven using jdk 11 or higher. You can check by running `mvn --version`.

## Run tests on authenticated server
TODO

## Rules and Procedures

### Procedure to Contribute
1. Create a new branch for your contributions
2. Write unit tests for any added code.
3. Create a pull request for review. Tag those that should review your code.
4. CodeClimate will check for code coverage and other issues in the pull request.
5. CI procedures will also run when a pull request is made. They must pass before code can be merged.
6. Only chief architect can merge changes to master, and only after QA manager's approval.

### Rules
* Spring allows different profiles that can run. All testing logic should only run and work when the `test` profile is set.
* Only `WebTestClient` should be used when testing the controllers. [One example can be found here](https://spring.io/guides/gs/reactive-rest-service/)
* Our code should be using the [Reactive model](https://projectreactor.io/). 
  [Spring's introduction to it is here](https://spring.io/reactive).

## Manual Deploy Project to Google App Engine

If we ever need to manually deploy our app, here is how to do it:

1. Make sure you have the [Google Cloud SDK](https://cloud.google.com/sdk) installed.
2. After Google Cloud SDK is installed, Run `gcloud init` and login using our project's email.
3. During `gcloud init`, select project name as the cloud project to use.
4. Run `mvn package appengine:deploy` in this folder.


## Resources
[Server Sent Events using Spring WebFlux](https://medium.com/better-programming/server-sent-events-on-react-and-spring-webflux-5f532b04633)

[Spring Cloud Firestore Integration](https://cloud.spring.io/spring-cloud-gcp/reference/html/#spring-data-cloud-firestore)

[Spring Data Elasticsearch Integration](https://docs.spring.io/spring-data/elasticsearch/docs/current/reference/html/#reference)

Great reference: [Spring Documentation on reactive programming](https://docs.spring.io/spring-framework/docs/current/reference/html/web-reactive.html). This includes how to write controllers, and test Spring WebFlux.

[Spring notes on reactive programming](https://spring.io/blog/2016/06/13/notes-on-reactive-programming-part-ii-writing-some-code)

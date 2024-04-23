# Little Shop with Coupons

## Contributors
- Billy - [LinkedIn](https://www.linkedin.com/in/wallacebilly1/) || [GitHub](https://github.com/wallacebilly1)

### Original Contributors (Little Esty Shop Group Project)
_This project started as a group project featuring the below team members.  Everything after forking down the original group project repo was completed by Billy._
- Lance - [LinkedIn](https://www.linkedin.com/in/lance-butler-jr-18b9442a1/) || [GitHub](https://github.com/LJ9332)
- Mel - [LinkedIn](https://www.linkedin.com/in/melissalanghoff/) || [GitHub](https://github.com/mel-langhoff)
- Rodrigo - [LinkedIn](https://www.linkedin.com/in/rodrigo-chavez1/) || [GitHub](https://github.com/RodrigoACG)

## Background
"Little Esty Shop" is a group project that required us to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.  From there, we were tasked with expanding the shop in our own repo, to include CRUD actions for coupons and revenue calculations for individual vendors and invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries

## Summary of Work Completed
- Built functionality detailed in [36 User Stories](./doc/user_stories.md)
- Added functionality detailed in [8 User Stories](https://backend.turing.edu/module2/projects/coupon_codes/)
- Developed all work using Test-Driven-Development, including the use of RSPec, Capybara, Shoulda-Matchers, Orderly, and SimpleCov to enhnace our testing
- Built database and associations from scratch to include 5 tables and 1 join table
- Used resources to support advanced and nested routing operations
- Created multiple ActiveRecord query methods to produce desired data from user stories
- Utilized form helpers for all forms to facilitate clean transfer of data between views, models, and controllers
- Utilized partials to DRY up code
- Adhered to and maintained MVC standards and best practices

## Ideas for Refactor
- Further DRY up code by adding in additional partials to views
- Update "form_with url" forms to be "form_with model" forms where possible
- Clean up and refine test data setup

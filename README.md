# ToyCity 4 - Udacidata

## Project Overview

Your boss loves what you did with the inventory app in ToyCity 3, but now has another request. She wants to be able to permanently store the data in a database, and update the database through the app rather than modify the database directly by hand.

In this project, you will use all the knowledge you learned in this Nanodegree program to create a special class called Udacidata that will map each Product object to an entry in the ToyCity database.

## Why Does This Matter?

Keeping large amounts of data organized is one of the number one challenges web developers address on a daily basis. The general organization of this project reflects the structure of a tool called ActiveRecord, which is used frequently as a Ruby on Rails developer.

## Completing this Project

You should have completed all the necessary steps for finishing this project in ToyCity 4. Before submitting, ensure your program returns the correct values for all the sample code provided in `app.rb`, and meets the following requirements.

* **Udacidata**: The `Udacidata` class has all of the required methods correctly implemented. Each method returns the expected return values outlined in the lesson and in `udacidata_test.rb`.
    * `all`
    * `create`
    * `first` and `first(n)`
    * `last` and `last(n)`
    * `destroy`
    * `update`
    * `find` and `find_by_#{attribute}`
    * `where`
* **Modules**: The `Analyzable` module contains all of the required methods correctly implemented. Each method returns the expected return values outlined in the lesson and in `analyzable_test.rb`
    * `count_by_brand`
    * `count_by_name`
    * `average_price`
    * `print_report`
* **Seeds**: The Faker gem is used to generate fake data in the `db_seed` method inside `seeds.rb`. `db_seed` populates the database with 10 new `Product`s.
* **Metaprogramming**: Metaprogramming concepts (e.g., re-opening classes, `define_method`, `class_eval`, etc.) are used to dynamically define the `find_by_#{attribute}` methods rather than hardcoding them.
* **Test-Driven-Development**: The student uses TDD and all of the tests in both `udacidata_test.rb` and `analyzable_test.rb` pass.
* **Modules**: The `Analyzable` module contains all of the required methods correctly implemented.
* **Final Output**: The code in `app.rb` is uncommented after the tests pass and outputs the expected return values to the terminal. (Code demonstrating error handling can remain commented out.)
* **Errors**: `ProductNotFoundError` is raised when non-existent product IDs are passed in as arguments.
* **.gitignore**: Files like `.DS_Store` and `data.csv` are added and ignored using a `.gitignore`

Additionally, the following requirements have been met:

* The project is submitted using GitHub, with regular commits
* Code follows proper style and naming conventions

## Submitting Your Project

Before submitting your project for evaluation, we recommend that you check that each of the following is true:

* Your program runs without any errors
* You are proud of your project and its output
* You completed your project according to the instructions
* You checked your project against the [rubric](https://review.udacity.com/#!/projects/6245552309/rubric)
* When you feel ready to submit, use the blue 'Submit Project' button below!

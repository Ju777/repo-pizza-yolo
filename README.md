# https://pizza-yolo.herokuapp.com/

## Like pizzas served on time !

### Credits :

DA SILVA PEREIRA DE OLIVEIRA Karine | CUBILIER Nicolas | FOURTHIES Alexis | ARMAGNAC Julien - (Mentor's project : Wilfried PAILLOT <-- thousands of thanks)

### Dev environment :

- Ruby 2.7.4, Rails 5.2.3.
- [DB link](https://lucid.app/lucidchart/3e386293-5ae3-4d02-9cc2-2126eb3ee238/edit?viewport_loc=-510%2C-170%2C3408%2C1622%2C0_0&invitationId=inv_aff0e8ba-0074-4bd9-8c87-56680cb03997#)
- [Trello](https://trello.com/b/zoSGglvd)

### Gems :

- table_print
- dotenv-rails
- devise
- stripe
- faker
- aws-sdk-s3
- friendly_id
- bootstrap
- jquery-rails

### How to use :

Either you open https://pizza-yolo.herokuapp.com/, or you can work locally as follow :

1. Clone this repo locally
2. After getting this new directory, create you local DB : rails db:create
3. Pass the migrations : rails db:migrate
4. Seed the DB : rails db:seed
5. Run the local server : rails server
6. In your web browser, open : http://localhost:3000/
7. Choose your pizz' :)

### Users stories

#### MVP Version

1. As a visitor, I can browse the products.
2. As a visitor, I can go to a product page.
3. As a visitor, I can login, and signup.
4. As a visitor, I can't see anyone's shopping cart.
5. As a user who has placed an order, I can receive a reminder when my product is ready.
6. As an authenticated user, I can do everything that visitors can do.
7. As an authenticated user, I can add products to my cart.
8. As an authenticated user, I can't see the shopping cart of other users.
9. As an authenticated user, I can see my current cart, and edit it.
10. As an authenticated user, I can place an order.
11. As a user, I can change my basic information.
12. As a user, I have a profile page where I can see my past orders.
13. As a site administrator, I can receive emails to notify me of an order placed.
14. As a user, I can purchase multiple copies of the same product.

#### Final version

15. As an administrator, I have access to a dashboard that gives me an overview of my orders.
16. As an administrator, I can create and modify the displayed products.
17. As a visitor, I can choose an available time to pick up my product.
18. As a visitor, I can check the available times to pick up an order.
19. As a user, I can choose the categories of the displayed products.
20. As a user, I can choose the categories of the displayed products. 20. As a user, the URLs are smart.

#### Optional features

21. As a visitor, I can have a shopping cart.
22. As a visitor, I can view a cart.
23. As a visitor, I can do a checkout.
24. As a loyal customer, the 10th pizza is free.
25. As a user I can order in a pizzeria in the city of my choice.

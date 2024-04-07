# Project README

## Prerequisites
- Ruby 3.1
- Rails 7.1
- Redis
- Ngrok

## Steps

### 1. Clone the project
git clone <project_url>

### 2. Install dependencies and set up database
bundle install
rake db:create db:migrate

### 3. Start the Server and Ngrok for creating a URL
- Start Rails server:
rails server
- Start Ngrok:
ngrok http <port_number>

### 4. Set up a server-based application on Zoho Books
- Use the Ngrok URL with /zoho_authorization/callback
- Obtain the client ID and client secret

### 5. Set environment variables for the Rails application

### 6. Run the server
- Execute the following command:
bin/dev
This command starts the Rails server and Sidekiq server.

### 7. Authorize the Zoho API app via OAuth
- Click on the authorization button when prompted.

### 8. Access token retrieval
- After completing the above step, the access token will be stored in the database.

### 9. Use Postman Collection to Create Customer and Expense
- Utilize the provided Postman Collection with minimum data.

### 10. Run Sidekiq Job Manual to Sync the data
- Manually run Sidekiq job to synchronize the data and check the data on Zoho.

## Improvement Areas
1. Write RSpec for all model services and jobs.
2. Optimize the method to generate the access token from the refresh token.
3. Call the ZohoOperationService while creating the customer and expense.
4. Create a separate controller or APIs to directly retrieve data from Zoho.


## Creator's Notes
We can discuss the improvement area over a call, and feel free to ask any queries or doubts.
For further discussion, you can reach me at: pareekkartavya@gmail.com
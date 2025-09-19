# Team: Group 6

>**Project Description**

The G6 MomoApp processes and visualizes mobile money (MoMo) transactions directly from SMS messages, enabling users and businesses to efficiently track and analyze financial activity. It parses SMS data in XML format, cleans and categorizes transactions, stores them in a relational database, and provides a frontend dashboard for interactive analysis and visualization. This project demonstrates skills in backend data processing, database management, and frontend visualization.

>**Team Members**

- [Christian Regnante] (GitHub: https://github.com/christian-regnante)
- [Semana Parfait] (GitHub: https://github.com/semanaparfait)
- [Sandrine Umugwaneza] (GitHub: https://github.com/sand02004)

>**Key Features:**

* Automated parsing and cleaning of MoMo SMS data.
* Categorization of transactions for easier analysis.
* Secure storage in a relational database.
* Interactive frontend dashboard for data visualization and reporting.
* Scalable architecture to handle growing data volumes.

>**Technologies to be used:** Python for backend processing, SQL for database management, HTML/CSS/JavaScript for frontend visualization, and XML/JSON for data handling.

>**System Architecture**

The application is organized into four main layers:
1. **Data Source**: Raw XML files containing MoMo SMS data.  
2. **ETL Pipeline**: Scripts to parse XML, clean/normalize data, categorize transactions, and load results into a relational database.  
3. **Storage**: Mysql database storing structured transaction data.  
4. **Frontend Dashboard**: Static HTML/CSS/JS interfacethat provides visual report chart of the process data.

   [View Architecture Diagram](<MomoApp_Design.png>)  
📂 Diagram file: `MomoApp_Design.png`

>**Scrum Board**

We are following Agile practices with a Scrum board.  
[View Scrum Board](<https://github.com/users/Christian-Regnante/projects/5>)  

# Updated README.md

>**Database Design Realeted Docs**

   * [View The Documenation](<docs/DatabaseDesign_Document.pdf>)

   * [View The ERD Diagram](<docs/erd_diagram.jpeg>)

### Folder Structure

* **/docs**: Contains documentation files, including the ERD diagram, user manuals, and other reference materials.
* **/database**: Contains SQL scripts for creating and managing the database and its tables.
* **/examples**: Sample JSON/XML files with MoMo transactions for testing and development purposes.
* **/src**: Contains the main application code for backend processing and frontend visualization.
* **/tests**: Contains test scripts to validate data processing logic and ensure correct categorization.
* **README.md**: This file, providing an overview and setup instructions for the project.

## Database Design

The database schema is designed to efficiently store and manage transaction data, maintain integrity, and support fast querying.

**Main Entities:**

* **User**: Stores user details.
* **Transaction**: Stores individual MoMo transactions.
* **Category**: Stores transaction categories (e.g., Payment, Transfer, Withdrawal).
* **Account**: Stores information about different mobile money accounts.

**Relationships:**

* One-to-many between Users and Transactions.
* One-to-many between Categories and Transactions.
* One-to-one or one-to-many relationships with Accounts, depending on user setup.

The ERD diagram in the `/docs` folder visually illustrates these relationships and key attributes.

## Setup and Usage

Follow these steps to set up and start using the G6 MomoApp:

1. **Clone the Repository**
   Clone the project to your local machine using Git:

   ```bash
   git clone <repository_url>
   cd g6-momoapp
   ```

<!-- 2. **Install Dependencies**
   Install the necessary Python packages for backend processing:

   ```bash
   pip install -r requirements.txt
   ``` -->

2. **Set Up the Database**

   * Navigate to the `/database` folder.
   * Run the SQL scripts provided to create the database and tables:

     ```sql
     -- Example for MySQL
     source create_database.sql;
     source create_tables.sql;
     ```
   * Update any configuration files with your database credentials.

4. **Load Sample Data**
   To test the system with sample MoMo transactions:

   * Navigate to `/examples` to find sample JSON file.
   * Import these files into the database or use the backend scripts to process them automatically.

<!-- 5. **Run the Backend Processing and Frontend Dashboard**
   Execute the script that processes transactions and starts the simple HTML/JS dashboard:

   ```bash
   python app.py
   ```

   Open your browser and navigate to `http://localhost:8000` (or the port specified) to access the dashboard. -->

<!-- 6. **Usage Tips and Notes**

   * Regularly update the database with new SMS transaction files to keep analytics up-to-date.
   * Check logs for any errors in data parsing or categorization.
   * Use filters in the dashboard to analyze transactions by type, date, or amount.
   * Ensure that any new data follows the expected XML/JSON format to prevent processing errors.
   * For production environments, consider automating data ingestion and dashboard updates to maintain continuous operation. -->



<!-- ## 📂 Project Structure (planned) -->

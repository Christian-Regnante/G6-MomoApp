# Team: Group 6

>**Project Description**

The G6 MomoApp processes and visualizes mobile money (MoMo) transactions directly from SMS messages, enabling users and businesses to efficiently track and analyze financial activity. It parses SMS data in XML format, cleans and categorizes transactions, stores them in a relational database, provides a frontend dashboard for interactive analysis and visualization, and exposes a **secure REST API** for programmatic access. This project demonstrates skills in backend data processing, database management, frontend visualization, API development, and security best practices.

>**Team Members**

- [Christian Regnante] (GitHub: https://github.com/christian-regnante)  
- [Semana Parfait] (GitHub: https://github.com/semanaparfait)  
- [Sandrine Umugwaneza] (GitHub: https://github.com/sand02004)

>**Submission**

PDF Documentation Report can be found in the [docs folder](<docs/>):
- [Database Design Document](<docs/DatabaseDesign_Document.pdf>)
- [API PDF Report Documentation](<docs/API_Documentation.pdf>)

>**Key Features:**  

* Automated parsing and cleaning of MoMo SMS data.  
* Categorization of transactions for easier analysis.  
* Secure storage in a relational database.  
* Interactive frontend dashboard for data visualization and reporting.  
* Scalable architecture to handle growing data volumes.  
* **REST API with full CRUD functionality**, allowing external applications to retrieve, create, update, and delete transaction records.  
* **Basic Authentication** securing API endpoints.  
* Efficient **DSA-based search algorithms** (linear search and dictionary lookup) to demonstrate performance optimization.

>**Technologies to be used:** Python for backend processing and API development, SQL for database management, HTML/CSS/JavaScript for frontend visualization, XML/JSON for data handling, and `http.server` for the REST API implementation.

---

>**System Architecture**

The application is organized into five main layers:

1. **Data Source**: Raw XML files containing MoMo SMS data.  
2. **ETL Pipeline**: Scripts to parse XML, clean/normalize data, categorize transactions, and load results into a relational database.  
3. **Storage**: MySQL database storing structured transaction data.  
4. **Frontend Dashboard**: Static HTML/CSS/JS interface providing visual reports of processed data.  
5. **REST API Layer**: Plain Python API exposing transaction records securely to clients with Basic Authentication and supporting full CRUD operations.

[View Architecture Diagram](<MomoApp_Design.png>)  
📂 Diagram file: `MomoApp_Design.png`  

---

>**Scrum Board**

We are following Agile practices with a Scrum board.  
[View Scrum Board](<https://github.com/users/Christian-Regnante/projects/5>)  

---

>**Database Design Related Docs**

* [View The Documentation](<docs/DatabaseDesign_Document.pdf>)  
* [View The ERD Diagram](<docs/erd_diagram.jpeg>)  

---

### Folder Structure

* **/docs**: Documentation files, including ERD diagram, user manuals, API docs, and other reference materials.
* **/api**: REST API implementation files, including request handlers and routing logic.
* **/dsa**: Data Structures and Algorithms implementations for efficient data processing and retrieval.
* **/database**: SQL scripts for creating and managing the database and its tables.  
* **/examples**: Sample XML/JSON files with MoMo transactions for testing and development purposes.  
* **/src**: Backend processing scripts, REST API code, and frontend visualization.  
* **/tests**: Scripts to validate data processing logic, API endpoints, and DSA search performance.  
* **README.md**: This file, providing an overview and setup instructions for the project.  

---

## Database Design

The database schema efficiently stores and manages transaction data, maintains integrity, and supports fast querying.

**Main Entities:**

* **User**: Stores user details.  
* **Transaction**: Stores individual MoMo transactions.  
* **Category**: Stores transaction categories (Payment, Transfer, Withdrawal, Deposit, etc.).  
* **Account**: Stores information about different mobile money accounts.  

**Relationships:**

* One-to-many between Users and Transactions.  
* One-to-many between Categories and Transactions.  
* One-to-one or one-to-many relationships with Accounts, depending on user setup.  

The ERD diagram in the `/docs` folder visually illustrates these relationships and key attributes.

---

## REST API Implementation

The project now includes a **secure REST API** for programmatic access to transactions:

**Endpoints:**

| Endpoint | Method | Description | Auth Required |
|----------|--------|-------------|---------------|
| /transactions | GET | Retrieve all transactions | Yes |
| /transactions/<id> | GET | Retrieve a specific transaction | Yes |
| /transactions | POST | Add a new transaction | Yes |
| /transactions/<id> | PUT | Update a transaction | Yes |
| /transactions/<id> | DELETE | Delete a transaction | Yes |

**Authentication & Security:**

* Basic Authentication is implemented for all endpoints.  
* Demo credentials for testing:  
  - Admin: `admin` / `password`  
* Unauthorized access returns `401 Unauthorized`.  
* Reflection: Basic Auth is simple but weak for production; stronger alternatives include **JWT**, **OAuth2**, and **API keys over HTTPS**.

**Why Basic Auth is Weak:**

* Credentials are sent with every request, often only base64-encoded, making them vulnerable if intercepted.  
* Without HTTPS, attackers can easily capture usernames and passwords.  
* No token expiration means compromised credentials remain valid until manually changed.  
* Lacks fine-grained access control and revocation capabilities.  
* Recommended alternatives include OAuth2, JWT tokens, and API keys with HTTPS to improve security and control.

**Request Examples (curl):**

```bash
# List all transactions
curl -u admin:password http://localhost:8080/transactions

# Get transaction by ID
curl -u admin:password http://localhost:8080/transactions/1

# Add new transaction
curl -u admin:password -X POST -H "Content-Type: application/json" \
    -d '{"id": "13443", "sender": "M-Money", "receiver_name": "Semana", "receiver_phone": null, "amount": 600000.0, "type": "payment", "timestamp": "1715369560245", "body": "TxId: 51732411227. Your payment of 600000 RWF to Samuel Carter 95464 has been completed at 2024-05-10 21:32:32. Your new balance: 987400 RWF. Fee was 0 RWF.Kanda*182*16# wiyandikishe muri poromosiyo ya BivaMoMotima, ugire amahirwe yo gutsindira ibihembo bishimishije."}' \
    http://localhost:8080/transactions
```

---

## Data Structures & Algorithms (DSA Integration)

To demonstrate efficient searching:

* **Linear Search**: Scans the transaction list sequentially to find a record by ID (O(n)).  
* **Dictionary Lookup**: Uses a dictionary index (`id → transaction`) for O(1) average-time lookup.  
* **Comparison Results (1000*20 searches)**:
  - Linear search total time: 2.882248 seconds  
  - Dictionary lookup total time: 0.032148 seconds  
  - Average linear per lookup: 0.000144112 seconds  
  - Average dict per lookup: 0.000001607 seconds  
* **Analysis**: Dictionary lookup is faster because it uses O(1) average-time hashing lookup, while linear search is O(n).  

This demonstrates the importance of selecting proper data structures for performance-critical operations in APIs.

---

## Setup and Usage

1. **Clone the Repository**:

```bash
git clone <repository_url>
cd g6-momoapp
```

2. **Set Up the Database**:

* Navigate to the `/database` folder.  
* Run the SQL scripts to create the database and tables:

```sql
source create_database.sql;
source create_tables.sql;
```

* Update configuration files with your database credentials.

3. **Run the REST API**:

```bash
python src/api.py
```

* Access endpoints via curl or Postman (see Authentication & Security section).  

4. **Testing & Validation**:

* Test endpoints for GET, POST, PUT, DELETE.  
* Validate DSA performance using the scripts in `/tests`.
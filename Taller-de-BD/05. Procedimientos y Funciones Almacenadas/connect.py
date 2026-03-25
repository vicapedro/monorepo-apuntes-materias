import pyodbc

# Define your connection parameters
server = 'localhost'  # e.g., 'localhost', 'your_server_ip'
database = 'northwind'
username = 'sa'
password = 'Gestion8.0'

# Create the connection string
# The DRIVER name might vary depending on your installed driver version and OS
cnxn_str = (
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={server};"
    f"DATABASE={database};"
    f"UID={username};"
    f"PWD={password}"
)

try:
    # Establish the connection
    cnxn = pyodbc.connect(cnxn_str)
    cursor = cnxn.cursor()

    # Example: Execute a query
    cursor.execute("SELECT @@SERVERNAME AS ServerName")
    row = cursor.fetchone()
    if row:
        print(f"Connected to SQL Server: {row.ServerName}")

    # Perform other database operations (e.g., insert, update, delete)

except pyodbc.Error as ex:
    sqlstate = ex.args[0]
    print(f"Error connecting to SQL Server: {sqlstate}")

finally:
    # Close the connection
    if 'cnxn' in locals() and cnxn:
        cnxn.close()
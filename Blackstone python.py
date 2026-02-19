import requests 
import psycopg2
# Daily Stock Prices
url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=BX&apikey=SY48N3VT07QDVPS1'
response = requests.get(url)
stock1 = response.json()
print("stock keys :", stock1.keys())

# Weekly Stock Prices
url =  'https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=BX&apikey=SY48N3VT07QDVPS1'
response = requests.get(url)
stock2 = response.json()
print("stock2 keys:", stock2.keys())
# Balance Sheet
url =  'https://www.alphavantage.co/query?function=BALANCE_SHEET&symbol=BX&apikey=SY48N3VT07QDVPS1'
response = requests.get(url)   
balance_sheet= response.json()
print("balance_sheet keys:", balance_sheet.keys())







# Connect Supabase database
connection = psycopg2.connect(
    host="aws-1-us-east-1.pooler.supabase.com",
    database="postgres",
    user="postgres.ywhqwmojneuygquzseab",
    password="Blazray25$$",
    port=6543
)
cursor = connection.cursor()

#Time Series (Daily)



# Time Series (Weekly)
time_series_weekly = stock2['Time Series (Weekly)']

# Inserting data into PostgreSQL database
for date, data in time_series_daily.items():
    sql = "INSERT INTO time_series_daily (day, open, high, low, close, volume) VALUES (%s, %s, %s, %s, %s, %s)"
    val = (
        date,
        float(data['1. open']),
        float(data['2. high']),
        float(data['3. low']),
        float(data['4. close']),
        int(data['5. volume'])
    )
    cursor.execute(sql, val)

connection.commit()
print(cursor.rowcount, "records inserted successfully into time_series_daily table")

cursor.close()
connection.close()


for date, data in time_series_weekly.items():
    sql = "INSERT INTO time_series_weekly (day, open, high, low, close, volume) VALUES (%s, %s, %s, %s, %s, %s)"
    val = (
        date,
        float(data['1. open']),
        float(data['2. high']),
        float(data['3. low']),
        float(data['4. close']),
        int(data['5. volume'])
    )
    cursor.execute(sql, val)

connection.commit()
print(cursor.rowcount, "records inserted successfully into time_series_daily table")

cursor.close()
connection.close()

for report in balance_sheet['annualReports']:
    cursor.execute("""
        INSERT INTO balance_sheet (fiscalDateEnding, reportedCurrency, totalAssets, totalLiabilities, totalShareholderEquity)
        VALUES ( %s, %s, %s, %s, %s)
    """, (
        report['fiscalDateEnding'],
        report['reportedCurrency'],
        report['totalAssets'],
        report['totalLiabilities'],
        report['totalShareholderEquity']
    ))
    cursor.execute(sql, val)

connection.commit()
print(cursor.rowcount, "records inserted successfully into time_series_daily table")

cursor.close()
connection.close()



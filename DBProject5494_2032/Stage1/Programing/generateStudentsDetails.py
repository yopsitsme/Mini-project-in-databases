import random
from datetime import datetime, timedelta

# Configuration
NUM_STUDENTS = 200
STARTING_ID = 201  # Start from ID 201 (assuming 1-200 are already used)
OUTPUT_FILE = "insert_200_students.sql"

# Data pools
first_names = ['David', 'Sarah', 'Michael', 'Yael', 'Rachel', 'Avi', 'Daniel', 'Miriam', 
               'Joshua', 'Leah', 'Benjamin', 'Rebecca', 'Jacob', 'Hannah', 'Aaron', 'Esther', 
               'Samuel', 'Ruth', 'Noah', 'Naomi', 'Isaac', 'Deborah', 'Eli', 'Tamar', 'Joseph', 
               'Abigail', 'Adam', 'Maya', 'Ethan', 'Shira', 'Moshe', 'Rivka', 'Yosef', 'Chana',
               'Shlomo', 'Dina', 'Avraham', 'Sara', 'Yitzchak', 'Malka', 'Yaakov', 'Tova']

last_names = ['Cohen', 'Levi', 'Ben-Ami', 'Mizrahi', 'Stern', 'Goldstein', 'Friedman', 'Katz',
              'Shapiro', 'Klein', 'Rosen', 'Weiss', 'Levy', 'Peretz', 'Avraham', 'Davidov',
              'Israeli', 'Zion', 'Sharon', 'Carmel', 'Golan', 'Galili', 'Tal', 'Bar', 'Alon',
              'Nir', 'Or', 'Chen', 'Paz', 'Gil', 'Mor', 'Oren', 'Eitan', 'Gal', 'Raz']

streets = ['Rothschild', 'Herzl', 'HaNassi', 'Ben Gurion', 'Dizengoff', 'Allenby', 
           'King George', 'Jabotinsky', 'Weizmann', 'Begin', 'Rabin', 'Basel', 'Nordau',
           'Bialik', 'Ahad HaAm', 'Sheinkin', 'Ibn Gabirol', 'Sokolov', 'Gordon', 'Frishman']

cities = ['Tel Aviv', 'Jerusalem', 'Haifa', 'Beersheba', 'Netanya', 'Rishon LeZion',
          'Petah Tikva', 'Ashdod', 'Holon', 'Ramat Gan', 'Rehovot', 'Bat Yam', 'Kfar Saba']

def random_date(start_year, end_year):
    """Generate a random date between start_year and end_year"""
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)
    delta = end - start
    random_days = random.randint(0, delta.days)
    return (start + timedelta(days=random_days)).strftime('%Y-%m-%d')

def generate_phone():
    """Generate Israeli phone number"""
    prefix = random.choice(['050', '052', '053', '054', '055', '058'])
    number = random.randint(1000000, 9999999)
    return f"{prefix}-{number}"

def generate_email(first_name, last_name, id_num):
    """Generate email address"""
    return f"{first_name.lower()}.{last_name.lower()}{id_num}@email.com"

def generate_address():
    """Generate Israeli address"""
    street = random.choice(streets)
    number = random.randint(1, 150)
    city = random.choice(cities)
    return f"{street} {number}, {city}"

def escape_sql_string(s):
    """Escape single quotes for SQL"""
    return s.replace("'", "''")

def generate_students_sql():
    """Generate SQL file with 200 new students"""
    
    sql_content = []
    sql_content.append("-- SQL Script to Insert 200 New Students")
    sql_content.append("-- Generated on: " + datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
    sql_content.append("-- This script adds students with IDs " + str(STARTING_ID) + "-" + str(STARTING_ID + NUM_STUDENTS - 1))
    sql_content.append("")
    
    # Track data for participate_in table
    student_ids = []
    
    # Generate person and student records
    sql_content.append("-- =====================================================")
    sql_content.append("-- INSERT INTO PERSON TABLE")
    sql_content.append("-- =====================================================\n")
    
    for i in range(NUM_STUDENTS):
        student_id = STARTING_ID + i
        student_ids.append(student_id)
        
        first_name = random.choice(first_names)
        last_name = random.choice(last_names)
        name = f"{first_name} {last_name}"
        birth_date = random_date(2005, 2018)  # Students aged 7-20
        email = generate_email(first_name, last_name, student_id)
        phone = generate_phone()
        
        sql = f"INSERT INTO person (id, name, birth_date, email, phone) VALUES ({student_id}, '{escape_sql_string(name)}', '{birth_date}', '{email}', '{phone}');"
        sql_content.append(sql)
    
    sql_content.append("\n-- =====================================================")
    sql_content.append("-- INSERT INTO STUDENT TABLE")
    sql_content.append("-- =====================================================\n")
    
    for student_id in student_ids:
        address = generate_address()
        sql = f"INSERT INTO student (id, addres) VALUES ({student_id}, '{escape_sql_string(address)}');"
        sql_content.append(sql)
    
    # Generate participate_in records (students enrolling in groups)
    sql_content.append("\n-- =====================================================")
    sql_content.append("-- INSERT INTO PARTICIPATE_IN TABLE")
    sql_content.append("-- (Enrolling students in sports groups)")
    sql_content.append("-- =====================================================\n")
    
    # Assuming groups exist with IDs 1-200
    # Each student will enroll in 1-3 groups randomly
    participations = set()
    
    for student_id in student_ids:
        num_groups = random.randint(1, 3)  # Each student joins 1-3 groups
        groups_for_student = random.sample(range(1, 201), num_groups)
        
        for group_id in groups_for_student:
            # Avoid duplicates
            if (student_id, group_id) not in participations:
                participations.add((student_id, group_id))
                sql = f"INSERT INTO participate_in (student_id, group_id) VALUES ({student_id}, {group_id});"
                sql_content.append(sql)
    
    # Write to file
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        f.write('\n'.join(sql_content))
    
    # Print summary
    print(f"✓ SQL file generated successfully: {OUTPUT_FILE}")
    print(f"✓ Generated {NUM_STUDENTS} students (IDs {STARTING_ID}-{STARTING_ID + NUM_STUDENTS - 1})")
    print(f"✓ Total person records: {NUM_STUDENTS}")
    print(f"✓ Total student records: {NUM_STUDENTS}")
    print(f"✓ Total participate_in records: {len(participations)}")
    print(f"\nTo import the data:")
    print(f"1. Open pgAdmin or psql")
    print(f"2. Run the SQL file: {OUTPUT_FILE}")
    print(f"3. Check the verification queries at the end")

if __name__ == "__main__":
    try:
        generate_students_sql()
    except Exception as e:
        print(f"Error generating SQL file: {e}")
        raise
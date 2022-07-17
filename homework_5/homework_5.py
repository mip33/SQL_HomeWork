from typing import Optional
import psycopg2
from psycopg2._psycopg import connection


def create_db(conn: connection) -> None:
    user_table = """
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            first_name VARCHAR(255) NOT NULL,
            last_name VARCHAR(255) NOT NULL,
            email VARCHAR(255) NOT NULL UNIQUE
        );
    """

    phone_table = """
        CREATE TABLE IF NOT EXISTS phones (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL,
            phone VARCHAR(255) NOT NULL,
            FOREIGN KEY (user_id) REFERENCES users (id)
        );
    """

    with conn.cursor() as cursor:
        cursor.execute(user_table)
        cursor.execute(phone_table)

        conn.commit()


def add_client(conn: connection, first_name, last_name, email, phones=None) -> None:
    with conn.cursor() as cursor:
        cursor.execute("""
            INSERT INTO users (first_name, last_name, email)
            VALUES (%s, %s, %s)
        """, (first_name, last_name, email))

        conn.commit()

        if phones:
            cursor.execute("""
                SELECT id
                FROM users
                WHERE first_name = %s AND last_name = %s AND email = %s
            """, (first_name, last_name, email))

            user_id = cursor.fetchone()[0]

            for phone in phones:
                cursor.execute("""
                    INSERT INTO phones (user_id, phone)
                    VALUES (%s, %s)
                """, (user_id, phone))

        conn.commit()


def add_phone(conn: connection, client_id, phone) -> None:
    with conn.cursor() as cursor:
        cursor.execute("""
            INSERT INTO phones (user_id, phone)
            VALUES (%s, %s)
        """, (client_id, phone))

        conn.commit()


def change_client(conn: connection, client_id, first_name=None, last_name=None, email=None, phones=None) -> None:
    with conn.cursor() as cursor:
        update_user_query = []

        if first_name:
            update_user_query.append(f"first_name = '{first_name}'")
        if last_name:
            update_user_query.append(f"last_name = '{last_name}'")
        if email:
            update_user_query.append(f"email = '{email}'")

        cursor.execute(f"""
            UPDATE users
            SET {','.join(update_user_query)}
            WHERE id = {client_id}
        """)

        if phones:
            cursor.execute("""
                DELETE FROM phones
                WHERE user_id = %s
            """, (client_id,))

            for phone in phones:
                cursor.execute("""
                    INSERT INTO phones (user_id, phone)
                    VALUES (%s, %s)
                """, (client_id, phone))

        conn.commit()


def delete_phone(conn: connection, client_id, phone) -> None:
    with conn.cursor() as cursor:
        cursor.execute("""
            DELETE FROM phones
            WHERE user_id = %s AND phone = %s
        """, (client_id, phone))

        conn.commit()


def delete_client(conn: connection, client_id) -> None:
    with conn.cursor() as cursor:
        cursor.execute("""
            DELETE FROM phones
            WHERE user_id = %s
        """, (client_id,))

        cursor.execute("""
            DELETE FROM users
            WHERE id = %s
        """, (client_id,))

        conn.commit()


def find_client(conn: connection, first_name=None, last_name=None, email=None, phone=None) -> Optional[tuple]:
    with conn.cursor() as cursor:
        query = []

        if first_name:
            query.append(f"first_name='{first_name}'")
        if last_name:
            query.append(f"last_name='{last_name}'")
        if email:
            query.append(f"email='{email}'")
        if phone:
            query.append(f"phone='{phone}'")

        sql = 'AND '.join(query)

        cursor.execute(f"""
            SELECT users.id, first_name, last_name, email
            FROM users
            JOIN phones p ON users.id = p.user_id
            WHERE {sql}
        """)

        return cursor.fetchone()[0]


with psycopg2.connect(database="postgres", user="postgres", password="postgres",
                      port="5432", host="localhost") as conn:
    create_db(conn)
    add_client(conn, "John", "Smith", "john@smith.com", ["+71234567890", "+71234567891"])
    user_id = find_client(conn, first_name="John", phone="+71234567891")
    add_phone(conn, user_id, "+71234567890")
    change_client(conn, user_id, first_name="John", last_name="Smith", email="john2@smith.com", phones=["+71234567811"])
    delete_phone(conn, user_id, "+71234567811")
    delete_client(conn, user_id)
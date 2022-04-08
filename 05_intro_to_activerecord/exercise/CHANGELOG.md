# Add sqlite3 gem to Gemfile

```bash
bundle add sqlite3
```

# Add a Database called dog_walker.db

From the demo directory in the terminal:

```bash
mkdir db
sqlite3 db/appointments_tracker.db
```

and exit the prompt (ctrl + D)

Add a file called `db/01_create_appointments.sql` with the following content:

```sql
CREATE TABLE appointments(
  id INTEGER PRIMARY KEY,
  time DATETIME,
  doctor STRING,
  patient STRING,
  purpose STRING,
  notes STRING,
  canceled BOOLEAN DEFAULT FALSE
);
```

Run the following command to create the appointments table:

```bash
sqlite3 db/appointments_tracker.db < db/01_create_appointments.sql
```


# Add database configuration to config/environment.rb

Add these lines above the `require_all "lib"`
```rb
DB = SQLite3::Database.new("db/dog_walker.db")
DB.results_as_hash = true
```
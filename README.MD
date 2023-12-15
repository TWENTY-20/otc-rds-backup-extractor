# Open Telekom Cloud RDS backup extractor
This Dockerfile can be used to build an image to decompress and serve Open Telekom Cloud's RDS backups.
RDS stands for 'Relational Database Service' and is one of Open Telekom Cloud's managed services.
It supports MySQL, PostgreSQL and Microsoft SQL Server.

The resulting Dockerimage allows restoring an RDS backup of a MySQL Database to a Docker container.
This is extremely useful as RDS backups are complex binary backups of low-level database files, not mere SQL dumps.
This is because RDS uses Percona XtraBackup and qpress to backup the database files.

The extraction and restoration of the database are fully automated, with the process executing necessary steps without manual intervention.
Only the exact MySQL version and the used MySQL flags need to be configured to match the RDS instance, ensuring seamless compatibility.

## Usage
1. Build the image
```
docker build -t otc-rds-extractor .
```

2. Decompress the backup 
```
docker run -v $(pwd)/backup.qp:/backup.qp -p 3306:3306 otc-rds-extractor
```

3. Access the restored database
The restored database can be accessed via 127.0.0.1 using the original credentials.
```
mysql -u user -h 127.0.0.1
```
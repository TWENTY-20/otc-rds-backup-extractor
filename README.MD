# OTC RDS backup extractor
This Dockerfile can be used to build an image to decompress and serve OTC RDS backups.

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
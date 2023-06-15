case $1 in 
    mongo)
        curl -L https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -o /app/rds-combined-ca-bundle.pem
        mongo --ssl --host $(aws ssm get-parameter --name ${env}.docdb.endpoint --with-decryption | jq '.Parameter.Value' | xargs):27017 --sslCAFile /app/rds-combined-ca-bundle.pem --username $(aws ssm get-parameter --name ${env}.docdb.user --with-decryption | jq '.Parameter.Value' | xargs) --password $(aws ssm get-parameter --name ${env}.docdb.pass --with-decryption | jq '.Parameter.Value' | xargs) </app/schema/$2.js
    ;;
    mysql)
        mysql -h $(aws ssm get-parameter --name ${env}.rds.endpoint --with-decryption | jq '.Parameter.Value' | xargs) -u $(aws ssm get-parameter --name ${env}.rds.user --with-decryption | jq '.Parameter.Value' | xargs) -p $(aws ssm get-parameter --name ${env}.rds.pass --with-decryption | jq '.Parameter.Value' | xargs) < /app/schema/$2.sql
    ;;
    *)
    echo "schema is supported only for mysql and mongo"
    exit 1
    ;;
esac
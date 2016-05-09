## OKI Env Setup
###Create a Vagrant dev box
- Install virtual box https://www.virtualbox.org/wiki/Downloads
- Install vagrant http://docs.vagrantup.com
```
cp ServerProvision/provision.rb.dist ServerProvision/provision.rb
```
- update provision.rb with your own settings (probably not needed)
```
vagrant up
vagrant ssh
```

###Symfony set up

On the VM:

1. `cd /var/www/api/symfony`
2. `composer install`
3. Take note of the IP address of the VM with "ifconfig". *eth1 inet addr:* its probably 192.168.33.10

On your localhost:

Edit your /etc/hosts file and add:
```
192.168.33.10   api.persuit.local
```

NB: Because the namespace in develop branch has changed, if you already have the codebase delete the parameters.yml and composer will recreate it for you.

###Database setup

On the VM:

1. `cd /var/www/api/symfony`
2. `./refresh.sh`

To clean the DB
* run `/refresh.sh` again

###Making requests
Make requests with Postman, curl or the front end client if you have it. 
1. Copy the desired OAuth access token from the oauth_access_token db table.
2. make a request with Headers: 
```
Authorization           Bearer <oauth access token>
Content-Type            application/json
```
3. Valid routes can be listed on the console with 
```
app/console debug:router
```
###Exceptions
- If you get an exceptions, Symfony provides a handy profiler at:
http://api.persuit.local/_profiler 
you can get a full stack trace from there.

- Sometimes exceptions are thrown before they are cached by the profiler so can also view exceptions the old fashioned way with:
```
sudo tail -f /var/log/apache2/project_error.log
```

###CronJob setup

- for Secondment opportunities automatic change status after expire
crontab -e 00 00 * * * php /var/www/api/symfony/app/console crontasks:run


###Image Uploads

Profile and Company images have been setup using the Flysystem library (http://flysystem.thephpleague.com/) to handle file uploads. Flysystem is a filesystem
abstraction which allows you to easily swap out a local filesystem for a remote one. This allows for development on a local dev environment which will only need
a new adaptor to be plugged in to work with various cloud solutions.. see http://flysystem.thephpleague.com/adapter/aws-s3-v3/ for an example.

####Adapters

The main config file (app/config/config.yml) sets up which adapters are available to be used. And where they will get their config from if needed. Currently we have the "local_adapter" and the "s3_adapter".
```
oneup_flysystem:
    adapters:
        local_adapter:
            local:
                directory: %kernel.root_dir%/../web/%upload.root_dir%
        s3_adapter:
            awss3v3:
                client: persuit.s3_client
                bucket: %s3.bucket%
                prefix: ~
```

####Local Adapter

The Dev environments have been configured (app/config/config_dev.yml) to use the local adapter by default. The dev environment config file should look like the following:
```
oneup_flysystem:
    filesystems:
        persuit_local:
            adapter: local_adapter
            alias: persuit_filesystem
```

Please note adapters for both local and s3 have been setup but the s3 adapter has been commented out. Importantly both of these adapters have an alias of "persuit_filesystem".
It is this alias that is use to determine which adapter should be used.

Other important config for the uploading lives in app/config/parameters.yml This specifies the directories where files will be saved to and is also passed into form handlers.
```
    upload.root_dir: upload
    upload.profile_dir: /profile
    upload.company_dir: /company
```

####S3 Adapter

To use the Amazon S3 adapter on either a local dev system or a production system do the following.
1) Find the correct config file for the environment and make sure the s3_adapter is aliased to "persuit_filesystem"
```
oneup_flysystem:
    filesystems:
        persuit_cloud:
            adapter: s3_adapter
            alias:   persuit_filesystem
```
2) Make sure the s3 config is in app/config/parameters.yml is all good. The most likely reason for the s3_adapter to not work is that the "s3.key" or "s3.secret" are incorrect.
If these are correct and issues persist check that the "s3.bucket" and "s3.region" are properly setup.
```
    s3.key: AKIAJ6VLILMKMT7VJCEA
    s3.secret: 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
    s3.bucket: persuit-dev-test1
    s3.region: ap-southeast-2
```
3) Lastly if all of the above are correct and there are still issues, check that there are no issues with the "persuit.s3_client" service. This service is also defined in src/Oki/Bundle/OkiBundle/Resources/config/services.yml and should look like the following. Note the parameters that should be defined in app/config/parameters.yml that this service requires:
```
    persuit.s3_client:
        class: Aws\S3\S3Client
        factory_class: Aws\S3\S3Client
        factory_method: factory
        arguments:
            -
                version: '2006-03-01' # or 'latest'
                region: "%s3.region%"
                credentials:
                    key: "%s3.key%"
                    secret: "%s3.secret%"
```

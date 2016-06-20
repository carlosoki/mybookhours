## Project Env Setup
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
3. Take note of the IP address of the VM with "ifconfig". *eth1 inet addr:* its probably 192.168.33.15

On your localhost:

Edit your /etc/hosts file and add:
```
192.168.33.15   myboobkhours.local
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


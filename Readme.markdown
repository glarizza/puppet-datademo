## Puppet Data Demo

This is the code I used in the 10/22/2011 demo for Camp Devops in Chicago. Feel free to take and use as you like.  Your node declaration should look something like this:

    node default {
      include tomcat, tomcat::service, tomcat::sunjdk
      tomcat::war { 'jenkins':
        filename => 'jenkins-1.419.war',
      }
      include yum
    }

Also, make sure to download the correct versions of the sunjdk, tomcat, and jenkins (see code).  All war files should be in modules/tomcat/files/war and your sunjdk and tomcat files should be in modules/tomcat/files

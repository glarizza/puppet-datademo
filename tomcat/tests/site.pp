node default {
  include tomcat
  include tomcat::sunjdk
  include tomcat::hudson
}

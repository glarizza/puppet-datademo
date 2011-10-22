include tomcat
tomcat::war { 'jenkins':
  filename => 'jenkins-1.419.war',
}

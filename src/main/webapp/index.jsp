<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="java.util.Date"%>
<%@page import="java.io.File,java.io.BufferedReader,java.io.FileReader" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>

<body>

    <%
        File hostnameFile = new File("/etc/hostname");
        BufferedReader br = new BufferedReader(new FileReader(hostnameFile));
        String hostname = br.readLine();

        String hostIP = inetAdd.getHostAddress();
    
        // get counter
        Integer counter = (Integer) session.getAttribute("demo.counter");
        if (counter == null) {
            counter = 0;
            session.setAttribute("demo.counter", counter);
        }

        // check for increment action
        String action = request.getParameter("action");

        if (action != null && action.equals("increment")) {
            // increment number
            counter = counter.intValue() + 1;

            // update session
            session.setAttribute("demo.counter", counter);
            session.setAttribute("demo.timestamp", new Date());
        }
    %>


    <header>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <a class="navbar-brand" href="#">
                <img  class="d-inline-block align-top" height="30" src="https://raw.githubusercontent.com/JasonFreeberg/clustered-jboss/main/Logo-Red_Hat-Microsoft_Azure-A-Standard-RGB.png">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                  <a class="nav-link" href="https://docs.microsoft.com/azure/app-service/configure-language-java?pivots=platform-linux">Documentation</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="https://docs.microsoft.com/azure/developer/java/ee/jboss-on-azure">JBoss EAP on Azure</a>
                </li>
              </ul>
            </div>
          </nav>
        <!-- Navbar -->

        <!-- Jumbotron -->
        <div class="p-5 text-center bg-light">
            <h1 class="mb-3">Red Hat JBoss EAP on Azure App Service</h1>
            <h4 class="mb-3">Demonstrating session replication across cluster nodes</h4>
            <a class="btn btn-primary" href="index.jsp?action=increment" role="button">Increment counter</a>
            <br>
            <br>
            <p>
                A counter is attached to your session information. Click the button above to increment the counter. When the page refreshes notice that the instance changes, but your session ID remains the same.
            </p>
        </div>
        <!-- Jumbotron -->
    </header>

    <br>
    <br>

    <!-- Main content -->
    <div class="container">
        <div class="row d-flex justify-content-center">
            <div class="col-12 col-lg-10">
                <!-- Table -->
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Description</th>
                            <th scope="col">Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Session Counter</td>
                            <td>Counter's value for this HTTP session</td>
                            <td><%= session.getAttribute("demo.counter") %></td>
                        </tr>
                        <tr>
                            <td>Current instance</td>
                            <td>The EAP instance serving this page</td>
                            <td><%= hostname %></td>
                        </tr>
                        <tr>
                            <td>Current instance IP address</td>
                            <td>The IP address of the EAP instance serving this page</td>
                            <td><%= hostIP %></td>
                        </tr>
                        <tr>
                            <td>Session ID</td>
                            <td>Your HTTP Session ID</td>
                            <td><%= session.getId() %></td>
                        </tr>
                        <tr>
                            <td>Last increment</td>
                            <td>Timestamp of the last increment</td>
                            <td><%= session.getAttribute("demo.timestamp") %></td>
                        </tr>
                    </tbody>
                </table>
                <!-- Table -->
            </div>
        </div>

        <br>
        <br>
        
        <div class="row d-flex justify-content-center">
            <div class="col-md-6 col-sm-12 text-center">
                <a class="btn btn-primary fluid" href="https://github.com/Azure-Samples/workshop-migrate-jboss-on-app-service#readme" role="button">Try the Jakarta EE migration workshop</a>
            </div>
        </div>

        <br>
        <br>

        <div class="row d-flex justify-content-center text-center">
            <div class="col-md-4 text-center">
                <img src="https://www.muylinux.com/wp-content/uploads/2019/05/RedHat.jpg"  class="img-responsive" height="200px">
            </div>
            <div class="col-md-4 text-center">
                <img src="https://swimburger.net/media/0zcpmk1b/azure.jpg" class="img-responsive" height="200px">
            </div>
        </div>

    </div>
    <!-- Main content -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
    </script>
</body>

</html>
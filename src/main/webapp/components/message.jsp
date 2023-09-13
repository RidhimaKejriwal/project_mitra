
<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
        // give message
%>

<div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong><%= message%></strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

<%
        session.removeAttribute("message");
    }
%>

<%
    String emsg = (String) session.getAttribute("error_message");
    if (emsg != null) {
        //prints
%>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong><%= emsg %></strong> 
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

<%
        session.removeAttribute("error_message");
    }
%>

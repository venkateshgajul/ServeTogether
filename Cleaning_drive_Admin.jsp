<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RIVER CLEANING DRIVE</title>
<style>
     body {
        font-family: Arial, sans-serif;
        background-color: white;
        margin: 0;
        padding: 20px;
        color: black;
    }
    table {
        width: 100%;
        max-width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        background-color: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        word-wrap: break-word;
    }
    th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        font-size: 12px; 
    }
    th {
        background-color: #FAEDCE;
        color: black;
    }

    #downloadPDF, #sortBtn {
        background-color: #FAEDCE;
        color: black;
        padding: 10px 20px;
        border: 1px solid black;
        font-size: 16px;
        margin-top: 20px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    #downloadPDF:hover, #sortBtn:hover {
        background-color: grey;
    }
    .h1 {
        text-align: center;
        color: black;
        margin-bottom: 40px;
    }

    select {
        padding: 10px;
        margin-right: 10px;
        font-size: 16px;
    }

   
    @media print {
        table {
            page-break-inside: auto;
        }
        tr {
            page-break-inside: avoid;
            page-break-after: auto;
        }
    }
</style>
</head>
<body>
<div class="data">
<select id="sortOption">
    <option value="">Select Sorting Option</option>
    <option value="date">Date-wise Sorting</option>
    <option value="alphabetical">Alphabetical Sorting</option>
</select>
<button id="sortBtn">Sort Table</button>
<button id="downloadPDF">Download PDF</button>

<h1 class="h1">RIVER CLEANING DRIVE DATA</h1>

<%

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con;
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1","root","");
	PreparedStatement ps=con.prepareStatement("select Name, Email, Phone_number, Message, response_time from river_cleaning_drive");
	ResultSet rs=ps.executeQuery();
	
	out.println("<table id='responseTable'>");
    out.println("<thead><tr>");
    out.println("<th>Name</th>");
    out.println("<th>Email</th>");
    out.println("<th>Phone Number</th>");
    out.println("<th>Message</th>");
    out.println("<th>Response Time</th>");  
    out.println("</tr></thead>");
    out.println("<tbody>");
	
	while(rs.next())
	{
		 out.println("<tr>");
		 out.println("<td>" + rs.getString("Name") + "</td>");
         out.println("<td>" + rs.getString("Email") + "</td>");
         out.println("<td>" + rs.getString("Phone_number") + "</td>");
         out.println("<td>" + rs.getString("Message") + "</td>");
         out.println("<td>" + rs.getTimestamp("response_time") + "</td>");  
	   		out.println("</tr>");
	}
    out.println("</tbody>");
	out.println("</table>");
%>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>

<script>

function sortTable(table, column, isDate) {
    const rows = Array.from(table.querySelectorAll('tbody tr'));
    rows.sort((rowA, rowB) => {
        let cellA = rowA.cells[column].innerText.trim();
        let cellB = rowB.cells[column].innerText.trim();

        if (isDate) {
            return new Date(cellA) - new Date(cellB);
        } else {
            return cellA.localeCompare(cellB);
        }
    });

    rows.forEach(row => table.querySelector('tbody').appendChild(row));
}


let sortBtn = document.getElementById('sortBtn');
let sortOption = document.getElementById('sortOption');
sortBtn.addEventListener('click', () => {
    const table = document.getElementById('responseTable');

    if (sortOption.value === 'date') {
        sortTable(table, 3, true);  
    } else if (sortOption.value === 'alphabetical') {
        sortTable(table, 0, false);  
    } else {
        alert("Please select a valid sorting option.");
    }
});


let btn = document.getElementById('downloadPDF');
btn.addEventListener('click', () => {
    btn.style.display = 'none'; 
    sortBtn.style.display = 'none';  
    sortOption.style.display = 'none';  
    const pdfContent = document.querySelector('.data'); 
    const opt = {
        margin: [0.5, 0.5, 0.5, 0.5], 
        filename: 'RIVER_CLEANING_DRIVE_DATA.pdf',  
        image: { type: 'jpeg', quality: 0.98 },  
        html2canvas: { scale: 2, logging: true, dpi: 192, letterRendering: true },  
        jsPDF: { unit: 'in', format: 'a4', orientation: 'landscape' }  
    };

    html2pdf().from(pdfContent).set(opt).save().then(() => {
        btn.style.display = 'block';  
        sortBtn.style.display = 'block';  
        sortOption.style.display = 'block';  
    });
});
</script>

</body>
</html>

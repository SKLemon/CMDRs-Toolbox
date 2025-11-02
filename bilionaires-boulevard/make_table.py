import pandas as pd

HTML = """
<head>
    <style type="text/css">
	    table.tableizer-table {
		    font-size: 12px;
		    border: 1px solid #CCC; 
            font-family: Arial, Helvetica, sans-serif;
            background-color: rgba(0,0,0,0.7)
        } 
        .tableizer-table td {
            padding: 4px;
            margin: 3px;
            border: 1px solid #CCC;
        }
        .tableizer-table th {
            background-color: #FFB300; 
            color: #FFF;
            font-weight: bold;
            font-size: 14px;
        }
    </style>
    <style>
    input[type=button] {
        background-color: #FF9300;
        color: #383838;
        font-weight: bold;
        cursor: pointer;
        padding: 10px;
    }
    </style>
    <script>
        function CopyClick(InputElement) {
            var TdNode=InputElement.parentNode;
            
            const reg1 = /<h2>/
            const reg2 = /<\/h2>.*/

            const TextElement = document.createElement('textarea');
            TextElement.value = TdNode.innerHTML.replace(reg1, "").replace(reg2, "");
            document.body.appendChild(TextElement);
            TextElement.select();
            document.execCommand('copy');
            document.body.removeChild(TextElement);
            
        }
    </script>
</head>
<body>
    <table class="tableizer-table" id="MatTable">
        <thead>
            <tr bgcolor = "Black"><th>System</th><th>Body</th><th>Plants to Scan</th></tr>
        </thead>
        <tbody>"""
        

df = pd.read_csv(".\Final_Route.csv")

for index, row in df.iterrows():

    landmarks = row['Landmark Subtype'].split(', ')
    landmarks.sort()
    landmarks = '<input type="checkbox"> ' + '<br><input type="checkbox"> '.join(landmarks)
    
    table_row = """
            <tr>
                <td><center><H2>""" + row['System Name'] + """</H2><br><input style= "padding: 2px 5px;" type="button" value="Copy" onclick="CopyClick(this)"></center></td>
                <td><center><H2>""" + row['Body Name'].replace(row['System Name'] + " ", "") + """</H2></center></td>
                <td>""" + landmarks + """</td>
            </tr>"""
    HTML += table_row

HTML += """     </tbody>
    </table>
</body>
"""

with open('billionaires-boulevard.html','w') as f:
    f.write(HTML)
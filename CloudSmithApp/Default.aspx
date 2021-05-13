<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CloudSmithApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-3.4.1.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
    <script>
        function Validate() {
           
            $('#error p').remove();
            $('#result p').remove();
            
            var error = $('#error');
            
            var idNumber = $('#idnumber').val();

            var correct = true;
            
            // SA ID Number have to be 13 digits, so check the length
            if (idNumber.length != 13 || !isNumber(idNumber)) {
                error.append('<p>Invalid ID number!</p>');
                $('#result').empty();
                correct = false;
            }

            var tempDate = new Date(idNumber.substring(0, 2), idNumber.substring(2, 4), idNumber.substring(4, 6));
            
            var id_date = tempDate.getDate();
            var id_month = tempDate.getMonth();
            var id_year = tempDate.getFullYear();

            var fullDate = id_date + "-" + id_month + "-" + id_year;

            if (!((tempDate.getYear() == idNumber.substring(0, 2)) && (id_month == idNumber.substring(2, 4)) && (id_date == idNumber.substring(4, 6)))) {
                error.append('<p>Invalid ID number(Date)!</p>');
                $('#result').empty();
                correct = false;
            }

            // get the gender
            var genderCode = idNumber.substring(6, 10);
            var gender = parseInt(genderCode) < 5000 ? "Female" : "Male";

            // get citzenship
            var citzenship = parseInt(idNumber.substring(10, 11)) == 0 ? "Yes" : "No";

            var tempTotal = 0;
            var checkSum = 0;
            var multiplier = 1;
            for (var i = 0; i < 13; ++i) {
                tempTotal = parseInt(idNumber.charAt(i)) * multiplier;
                if (tempTotal > 9) {
                    tempTotal = parseInt(tempTotal.toString().charAt(0)) + parseInt(tempTotal.toString().charAt(1));
                }
                checkSum = checkSum + tempTotal;
                multiplier = (multiplier % 2 == 0) ? 1 : 2;
            }
            if ((checkSum % 10) != 0) {
                error.append('<p>Invalid ID number(checksum)!</p>');
                $('#result').empty();
                correct = false;
            };

            if (correct) {
                error.css('display', 'none');

                $('#result').empty();
                $('#result').append('<p>South African ID Number:   ' + idNumber + '</p><p>Birth Date:   ' + fullDate + '</p><p>Gender:  ' + gender + '</p><p>SA Citizen:  ' + citzenship + '</p>');
                return true;
            }
            else {
                error.css('display', 'block');
                return false;
            }

            
        }

        function isNumber(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }

        function readInput() {
            var btnSearch = document.getElementById('btnSearch');
            var counterMsg = $('#counter');
            var idNumber = $('#idnumber').val();
            if (idNumber.length < 13) {
                $('#counter').empty();
                $('#result').empty();
                counterMsg.append('ID number should be 13 digits long');
                btnSearch.disabled = true;
            }
            else {
                $('#counter').empty();
                if (Validate()) {                    
                    btnSearch.disabled = false;
                }
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

       
    </script>
     <table style="margin-top:10px">
         <tr>
             <td style="padding-right:7px; padding-left:7px">
    <p>Enter ID Number: <input id="idnumber" oninput="readInput()" maxlength="13" name="idno" onkeypress="return isNumberKey(event)" /> </p> 
             </td>
            <td>
               <p> <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" Width="100px" BackColor="#336699" ForeColor="White" /></p> 
            </td>
         </tr>
         <tr>
             <td>
                 <div id="counter"></div>
                 <div id="error"></div>
                 <div id="result"> </div>
             </td>
         </tr>
    </table>
    <div id="dvResults" runat="server" visible="false">
    <table style="margin-top:50px;  Width:1000px" runat="server" visible="true" id="tblResults">  
        <tr><td colspan="4" style="background-color:#336699; font:bold 300; color:white; text-align:center"><asp:Label ID="Label1" runat="server" ForeColor="White" Font-Bold="true" Text="RESULTS" ></asp:Label></td></tr>
       </table>
    <table style="margin-top:50px; border-collapse:separate" runat="server" visible="true" id="tbldResults">  
        
        <tr>
            <td style="padding:5px; background-color:#336699; color:white; width:70px">
                ID Number
            </td>
            <td style="padding:5px; width:100px">
                <asp:Label ID="lblIDNumber" runat="server" ></asp:Label>
            </td>
            <td style="padding:5px; background-color:#336699; color:white; width:70px">
                Date Of Birth
            </td>
            <td style="padding:5px; width:100px">
                <asp:Label ID="lblDateOfBirth" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr style="height:3px"><td></td></tr>
         <tr style="margin-top:10px">
            <td style="padding:5px; background-color:#336699; color:white; width:70px">
                Gender
            </td>
            <td style="padding:5px; width:100px">
                <asp:Label ID="lblGender" runat="server" ></asp:Label>
            </td>
            <td style="padding:5px; background-color:#336699; color:white; width:70px">
                SA Citizen
            </td>
            <td style="padding:5px; width:100px">
                <asp:Label ID="lblSACitizen" runat="server" ></asp:Label>
            </td>
        </tr>
        <tr style="height:3px"><td></td></tr>
        <tr>
            <td colspan="4">
                This ID number was queried  <asp:Label ID="lblCounter" runat="server" ForeColor="Red" Font-Bold="true" ></asp:Label>   time(s).
            </td>
        </tr>
        <tr style="height:30px"><td></td></tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="gvIDInfo" runat="server" Width="1000px" AutoGenerateColumns="False">
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" BackColor="#336699" />
                    <EmptyDataTemplate>
                                                No records found!
                                            </EmptyDataTemplate>
                    <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Holiday Name" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px" HeaderStyle-ForeColor="White">
                                                    <HeaderStyle ForeColor="white" Font-Bold="false" />
                                                    
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="400px" HeaderStyle-ForeColor="White">
                                                    <HeaderStyle ForeColor="white" Font-Bold="false" />
                                                   
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px" HeaderStyle-ForeColor="White">
                                                    <HeaderStyle ForeColor="white" Font-Bold="false" />
                                                   
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Type" HeaderText="Type" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px" HeaderStyle-ForeColor="White">
                                                    <HeaderStyle ForeColor="white" Font-Bold="false" />
                                                   
                                                </asp:BoundField>

                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
</div>
</asp:Content>

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace ADO
{
    public partial class Default : System.Web.UI.Page
    {           
        public string strSQL;
        public string cadenaConexion = ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString;
        public SqlConnection conexion;
        public SqlCommand comando;
        public SqlDataReader objDataReader;
        public int operacion;
        public int totalItemSeleccionados = 0;
        
        private void setSelectedItemsCounter()
        {
            lblTotalItemsSelected.Text = totalItemSeleccionados.ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setSelectedItemsCounter();
            }
        }

        protected void GridView_Clientes_DataBound(object sender, EventArgs e)
        {            
            GridViewRow pagerRow = GridView_Clientes.BottomPagerRow;         
            DropDownList pageList = (DropDownList)pagerRow.Cells[0].FindControl("PageDropDownList");
            Label pageLabel = (Label)pagerRow.Cells[0].FindControl("CurrentPageLabel");
            if (pageList.SelectedIndex == -1)
		    {                
                for (var i = 0; i < GridView_Clientes.PageCount; i++)
		    	{             
                    int pageNumber = i + 1;
                    ListItem item = new ListItem(pageNumber.ToString());
                    if (i == GridView_Clientes.PageIndex)
                        item.Selected = true;
                                  
                    pageList.Items.Add(item);
		    	}
            }
            if(pageLabel.Text != "")
		        {                 
                    int currentPage = GridView_Clientes.PageIndex + 1;                 
                    pageLabel.Text = "Página " + currentPage.ToString() + " de " + GridView_Clientes.PageCount.ToString();
                }
        }

        protected void GridView_Clientes_PreRender(object sender, EventArgs e)
        {            
            if (totalItemSeleccionados > 0)
            {
                btnQuitarSeleccionados.CssClass = "btn btn-lg btn-danger";
            }
            else
            {
                btnQuitarSeleccionados.CssClass = "btn btn-lg btn-danger disabled";
            }
        }

        public void GridView_Clientes_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {            
                if (e.Exception == null)
        		{            
                    lblInfo.Text = " ¡Cliente/s eliminado/s OK! ";
                    lblInfo.CssClass = "label label-success";
        		}
                else
        		{
                    lblInfo.Text = " ¡Se ha producido un error al intentar elimnar el/los cliente/s! ";
                    lblInfo.CssClass = "label label-danger";
                    e.ExceptionHandled = true;
                }            
        }

        protected void GridView_Clientes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblInfo.Text = "Total of selected items: ";
        }

        protected void GridView_Clientes_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            lblInfo.Text = "Total of selected items: ";
        }

        protected void btnQuitarSeleccionados_Click(object sender, EventArgs e)
        {            
            for (var i = 0; i < GridView_Clientes.Rows.Count; i++)
            {
                CheckBox CheckBoxElim = (CheckBox)GridView_Clientes.Rows[i].FindControl("chkEliminar");
                if (CheckBoxElim.Checked)
                    GridView_Clientes.DeleteRow(i);
            }
            GridView_Clientes.DataBind();
        }

        protected void chk_OnCheckedChanged(object sender, EventArgs e)
        {
            lblInfo.Text = "Total of selected items: ";
            for (var i = 0; i < GridView_Clientes.Rows.Count; i++)
            {
                CheckBox CheckBoxElim = (CheckBox)GridView_Clientes.Rows[i].FindControl("chkEliminar");
                if (CheckBoxElim.Checked)
                {
                    totalItemSeleccionados += 1;                    
                }
                setSelectedItemsCounter();
            }
        }

        protected void PageDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {            
            GridViewRow pagerRow = GridView_Clientes.BottomPagerRow;         
            DropDownList pageList = (DropDownList)pagerRow.Cells[0].FindControl("PageDropDownList");            
            GridView_Clientes.PageIndex = pageList.SelectedIndex;
            setSelectedItemsCounter();
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalClientes.Text = e.AffectedRows.ToString();
        }
 
    }
}
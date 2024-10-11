from utils.query_database import QueryDatabase
import plotly.express as px
import streamlit as st 

class ViewsTrend:
    def __init__(self) -> None:
        self.df = QueryDatabase("SELECT * FROM marts.views_per_date").df
        print(self.df)

    def display_plot(self):
        fig = px.line(self.df, x="Datum", y="Visningar")
        st.markdown("## Antal visningar under senaste månaden")
        st.plotly_chart(fig)

# create more graphs here
class OSTrend:
    def __init__(self) -> None:
        self.df = QueryDatabase("SELECT * FROM marts.OS_per_date").df

    def display_plots(self):
        df = self.df
        st.header("Visningar för senaste månaden sorterade efter operativsystem")
        operating_system = st.selectbox("Välj operativsystem", df.columns[1:])

        fig = px.line(
            data_frame=df,
            x=df["Datum"],
            y=df[operating_system],
            title=f"Visningar från {operating_system} användare 2024-08-13 - 2024-09-09",
            labels={"index": "Datum", operating_system: "Operativsystem"},
        )

        fig.update_layout(
           xaxis=dict(showgrid=False,),
           yaxis=dict(showgrid=False,
                      tick0 = 0),       
        )
        st.plotly_chart(fig)


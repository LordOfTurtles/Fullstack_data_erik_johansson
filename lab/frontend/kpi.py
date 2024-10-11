import streamlit as st
from utils.query_database import QueryDatabase

class ContentKPI:
    def __init__(self) -> None:
        self._content = QueryDatabase("SELECT * FROM marts.content_view_time;").df
        self._operating_system = QueryDatabase("SELECT * FROM marts.OS_summary OFFSET 1;").df

    def display_content(self):
        df = self._content
        st.markdown("## KPIer för videor")
        st.markdown("Nedan visas KPIer för totalt antal")

        kpis = {
            "videor": len(df),
            "visade timmar": df["Visningstid_timmar"].sum(),
            "prenumeranter": df["Prenumeranter"].sum(),
            "exponeringar": df["Exponeringar"].sum(),
        }

        for col, kpi in zip(st.columns(len(kpis)), kpis):
            with col: 
                st.metric(kpi, round(kpis[kpi]))
        st.dataframe(df)
    
    def display_OS_stats(self):
        df = self._operating_system
        st.markdown("## Vanligaste operativsystem")
        st.markdown("Nedan visas en lista på vilka operativssystem som används mest av tittare")
        st.dataframe(df)


# create more KPIs here
class OSKPI:
    def __init__(self) -> None:
        self._operating_system = QueryDatabase("SELECT * FROM marts.OS_summary OFFSET 1;").df

    def display_OS_stats(self):
        df = self._operating_system
        st.markdown("## Vanligaste operativsystem")
        st.markdown("Nedan visas en lista på vilka operativssystem som används mest av tittare")
        st.dataframe(df)

class AgeKPI:
    def __init__(self) -> None:
        self._ages = QueryDatabase("SELECT * FROM marts.viewer_ages;").df
    
    def display_age_stats(self):
        df = self._ages
        st.markdown("## Åldersdemografier")
        st.markdown("Nedan visas en lista med statistik för olika åldersdemografier")
        st.dataframe(df)
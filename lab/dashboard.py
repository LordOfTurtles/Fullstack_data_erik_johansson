import streamlit as st 
from frontend.kpi import ContentKPI
from frontend.graphs import ViewsTrend, OSTrend


# device_kpi = DeviceKPI()
content_kpi = ContentKPI()
views_graph = ViewsTrend()
os_graph = OSTrend()

def layout():
    st.markdown("# The data driven youtuber")
    st.markdown("Den här dashboarden syftar till att utforska datan i Kokchun's youtubekanal")
    # device_kpi.display_device_views()
    # device_kpi.display_device_summary()
    content_kpi.display_content()
    views_graph.display_plot()
    content_kpi.display_OS_stats()
    os_graph.display_plots()
    

if __name__ == "__main__":
    layout()
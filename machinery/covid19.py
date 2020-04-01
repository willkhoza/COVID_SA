import pandas as pd
from datetime import datetime

def get_first_dt(dat, out_name, n):
    """get the first date in which a series is greater than n
    
    Arguments:
        dat {pd.Series} -- [description]
        out_name {pd.DataFrame} -- [description]
        n {threshold days} -- [description]
    
    Returns:
        [dt] -- the date in which the time series passes a milestone
    """
    out_data = []
    for country in dat.T:
        try:
            dt = (dat.T[dat.T[country]>n]).index[0]
            dt = datetime.strptime(dt, "%m/%d/%y")
        except:
            dt = None
        out_data.append([country, dt])
    out_data = pd.DataFrame(out_data)
    out_data.columns = ['country', out_name]
    out_data.set_index('country', inplace = True)
    return out_data

def input_data(url):
    """ read time series data from the Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE) github
    repository into the enviroment.
    
    Arguments:
        url {str} -- the link to the relevent csv file
    
    Returns:
        dat -- a pandas dataframe with the data contained in the csv file
    """
    dat = pd.read_csv(url)
    dat.drop(['Province/State', 'Lat', 'Long'], axis = 1, inplace = True)
    dat = dat.groupby(['Country/Region']).sum()
    return dat

def get_death_data():
    return input_data("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")

def get_confirm_data():
    return input_data("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

def get_recovery_data():
    return input_data("https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")

def to_numeric(x):
    try:
        x = float(str(x).replace(',', ''))
    except:
        x = None
    return x

def to_decimal(x):
    try:
        x = str(x).replace("%", '')
        x = float(x)
    except:
        x = None
    return None

def get_population_data():
    dat = pd.read_csv("https://raw.githubusercontent.com/willkhoza/COVID_SA/master/worldometer/world_demographics_2020.csv")
    dat.set_index("Country", inplace = True)
    for i in ['Population', 'Annual_Change_Absolute', 'Density',
       'Land_Area', 'Migrants', 'Fert_Rate']:
       dat[i] = dat[i].apply(to_numeric)
    dat['Annual_Change']=dat['Annual_Change'].str.replace("%", "").astype(float)
    dat['Urban_Population']=dat['Urban_Population'].str.replace("%", "")
    dat['World_Share']=dat['World_Share'].str.replace("%", "").astype(float)
    return dat
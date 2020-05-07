# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import sklearn.preprocessing as skp

def load():
    path = 'Fuel_Consumption_Ratings_v2.csv'
    df = pd.read_csv(path, encoding ='latin1')
    df = df.dropna(axis=1, how='all')
    df = df.dropna(axis=0)
    
    cols = ['Engine Size', 'Cylinders', 'City (L/100 km)', 'Hwy (L/100 km)', 'Comb (L/100 km)', 'Comb (mpg)', 'CO2 Emissions', 'CO2 rating', 'Smog rating']
    df[cols] = df[cols].apply(pd.to_numeric)
    cols = ['Engine Size', 'Cylinders','Fuel type', 'City (L/100 km)', 'Hwy (L/100 km)', 'Comb (L/100 km)', 'Comb (mpg)', 'CO2 Emissions', 'CO2 rating', 'Smog rating']
    data = df[:][cols]
    data = pd.get_dummies(data)
    
    return data

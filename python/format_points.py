import argparse
import pandas as pd

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        prog='format_points.py',
        description='Takes in a CSV of coordinates, formats them so that they can be used as paths for polygons.',
        )
    parser.add_argument('-i', '--input_filename')
    parser.add_argument('-o', '--output_filename')
    parser.add_argument('-m', '--multiplier', default=12.7, help="convert to millimeters")

    args = parser.parse_args()
    df = pd.read_csv(args.input_filename)
    for var in ['x', 'y']:
       whole_number_with_fraction = df[var].str.extract('(\d+) (\d+)/(\d+)')
       fraction = df[var].str.extract('(\d+)/(\d+)')
       just_a_number = df[var].str.extract('^(\d+)$')
       ratio = fraction[0].astype(float) / fraction[1].astype(float)
       summation = whole_number_with_fraction[0].astype(float) + whole_number_with_fraction[1].astype(float) / whole_number_with_fraction[2].astype(float)
       tmp = summation.mask(summation.isna(), ratio)
       tmp = tmp.mask(tmp.isna(), just_a_number[0])
       # convert to millimeters
       df[f'{var}_cleaned'] = tmp.astype(float) * float(args.multiplier)

    print(df.apply(lambda row: f'[{row["x_cleaned"]}, {row["y_cleaned"]}]', axis=1).str.cat(sep=', '))




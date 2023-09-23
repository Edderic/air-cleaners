
import pandas as pd
import numpy as np
from scipy.optimize import fsolve

def gradient_descent(
    data,
    loss_function_derivatives={},
    variables={},
    num_iterations=10000,
    learning_rate=1e-2,
    tol=0.001
):
    """
    Parameters:
        data: pd.DataFrame
            columns are variables.
            Each row is an instance.

        loss_function_derivatives: dict
            Keys are string, representing the variable
            Values are callable, representing the partial derivative of the
            error function with respect to said variable.

        variables: dict
            Keys are string, representing the variable
            Values are the values of interest. These are the initial values,
            and will be updated over many iterations.

        num_iterations: int
            Number of iterations that will be done in gradient descent, unless
            the tolerance level is met.

        tol: float
            If each partial derivative meets the tolerance condition, then
            we've reached a local optima. Stop iterating.
    """
    for i in range(num_iterations):
        tolerance_is_met = True

        for v in variables:
            derivative_v = loss_function_derivatives[v](data, **variables)
            if derivative_v >= tol or -tol > derivative_v:
                tolerance_is_met = False

            variables[v] = variables[v] - derivative_v * learning_rate

        if tolerance_is_met:
            return variables

    return variables

def loss_function_cubic():
    """
    Loss function: ax3 + bx2 + cx + d
    """
    return {
        'd': lambda data, a, b, c, d: (2 * (a * data['x']**3 + b * data['x']**2 + c * data['x'] + d - data['y'])).sum(),
        'c': lambda data, a, b, c, d: (2 * data['x'] * (a * data['x']**3 + b * data['x']**2 + c * data['x'] + d - data['y'])).sum(),
        'b': lambda data, a, b, c, d: (2 * data['x']**2 * (a * data['x']**3 + b * data['x']**2 + c * data['x'] + d - data['y'])).sum(),
        'a': lambda data, a, b, c, d: (2 * data['x']**3 * (a * data['x']**3 + b * data['x']**2 + c * data['x'] + d - data['y'])).sum()
    }


def loss_function_tangent():
    """
    Loss function:  a * tan(bx + c) + d

    d
    -- a * tan(bx + c) + d = tan(bx + c)
    da

    d
    -- a * tan(bx + c) + d = a * sec^2(bx + c) * x
    db

    d
    -- a * tan(bx + c) + d = a * sec^2(bx + c)
    dc

    d
    -- a * tan(bx + c) + d = 1
    dd
    """

    return {
        'a': lambda data, a, b, c, d: (a * np.tan(b * data['x'] + c)).sum(),
        'b': lambda data, a, b, c, d: (a * data['x'] / np.cos(b * data['x'] + c) ** 2).sum(),
        'c': lambda data, a, b, c, d: (a / np.cos(b * data['x'] + c) ** 2).sum(),
        'd': lambda data, a, b, c, d: 1,
    }



if __name__ == '__main__':
    # root = fsolve(func, [1, 1, 1, 1])

    # In decimeters
    data = pd.DataFrame([
        {
            'x': 0.20,
            'y': -0.25,
        },
        {
            'x': 0.25,
            'y': 0,
        },
        {
            'x': 0.25,
            'y': 0,
        },
        {
            'x': 0.3125,
            'y': 0.15,
        },
        {
            'x': 0.875,
            'y': 0.30
        },
        {
            'x': 0.9375,
            'y': 0.375
        },
        {
            'x': 1.00,
            'y': 0.5,
        },
    ])

    variables={
        'a': 0.5,
        'b': 0.5,
        'c': 0.5,
        'd': 0.5,
    }

    results = gradient_descent(
        data,
        variables=variables,
        loss_function_derivatives=loss_function_cubic()
    )
    import pdb; pdb.set_trace()


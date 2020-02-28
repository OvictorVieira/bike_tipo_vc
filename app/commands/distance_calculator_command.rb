class DistanceCalculatorCommand

  class << self

    # Distance formula
    #
    # d(P,Q) = √(x_2 - x_1)² + (y_2 - y_1)²
    #
    def calculate_distance(x_1, x_2, y_1, y_2)

      sum_of_points = ((x_2 - x_1) ** 2) + ((y_2 - y_1) ** 2)

      Math.sqrt(sum_of_points)
    end

  end
end
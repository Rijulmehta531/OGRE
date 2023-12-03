//
//  QuantitativeReasoning_CS.swift
//  ogre
//
//  Created by Brian Johnson on 11/5/23.
//
// quantitative elements for study page

import SwiftUI

struct QuantitativeReasoning_CS: View {
    var body: some View {
        VStack {
            Text("Quantitative Reasoning")
                .foregroundColor(.purple)
                .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    QuantitativeReasoningCategorySelector(
                        categoryName: "Strategies/Tips",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    QuantitativeReasoningCategorySelector(
                        categoryName: "Arithmetic",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    QuantitativeReasoningCategorySelector(
                        categoryName: "Algebra",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    QuantitativeReasoningCategorySelector(
                        categoryName: "Geometry",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                    QuantitativeReasoningCategorySelector(
                        categoryName: "Data Analysis",
                        categoryDescription: "",
                        categoryIcon: ""
                    )
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 44)
        }
        .frame(height: 360)
    }
}

struct QuantitativeReasoningCategorySelector: View {
    let categoryName: String
    let categoryDescription: String
    let categoryIcon: String
    @State var isGeometryPopoverPresented = false
    @State var isAlgebraPopoverPresented = false
    @State var isArithmeticPopoverPresented = false
    @State var isDataAnalysisPopoverPresented = false
    @State private var categorySelected = false
    
    var body: some View {
        Button(action: {
            if(categoryName == "Strategies/Tips") {
                if let url = URL(string: "https://www.ets.org/gre/test-takers/general-test/prepare/content/quantitative-reasoning.html") {
                    UIApplication.shared.open(url)
                }
            } else if(categoryName == "Geometry") {
                self.isGeometryPopoverPresented = true
            } else if(categoryName == "Algebra") {
                self.isAlgebraPopoverPresented = true
            } else if(categoryName == "Arithmetic") {
                self.isArithmeticPopoverPresented = true
            } else if(categoryName == "Data Analysis") {
                self.isDataAnalysisPopoverPresented = true
            }
        }) {
            ZStack() {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(categorySelected ? .green : .purple)
                    .frame(width: 300, height: 300)
                VStack {
                    Text(categoryName)
                        .font(.custom("Optima-ExtraBlack", size: 25, relativeTo: .title2))
                    
                }
                .foregroundColor(.white)
            }
        }
        //GEOMETRY UNIT POPOVER SCREEN
        .popover(isPresented: $isGeometryPopoverPresented) {
            VStack(alignment: .leading) {
                Text("\nGeometry")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                    .background(.purple)
            }
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                //3.1 Lines and Angles
                Text("3.1 Lines and Angles")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/geometry-home/geometry-lines") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Tools of Geometry")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/geometry-home/geometry-angles") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Angles and Intersecting Lines")
                }
                Spacer()
                //3.2 Polygons
                Spacer()
                Text("3.2 Polygons")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/basic-geometry") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Perimeter, area, and volume")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/geometry-home/geometry-angles") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Angles and intersecting lines")
                }
                Spacer()
                //3.3 Triangles
                Spacer()
                Text("3.3 Triangles")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/geometry/congruence") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Congruence")
                }
                
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/similarity") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Similarity")
                }
                
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/geometry/right-triangles-topic") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Right triangles and trigonometry")
                }
                
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/basic-geometry") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Perimeter, area, and volume")
                }
                Spacer()
                //3.4 Quadrilaterals
                Text("3.4 Quadrilaterals")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/geometry/congruence") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Quadrilaterals")
                }
                
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/basic-geometry") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Perimeter, area, and volume")
                }
                Spacer()
                //3.5 Circles
                Spacer()
                Text("3.5 Circles")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/cc-geometry-circles") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Circles")
                }
                
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/basic-geometry") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Perimeter, area, and volume")
                }
                Spacer()
                //3.6 3D Figures
                Spacer()
                Text("3.5 Three-Dimentional Figures")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/geometry/basic-geometry") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Perimeter, area, and volume")
                }
            }
        }
        //ALGEBRA UNIT POPOVER SCREEN
        .popover(isPresented: $isAlgebraPopoverPresented) {
            VStack(alignment: .leading) {
                Text("\nArithmetic")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                    .background(.purple)
            }
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                //2.1 Operations with Algebraic Expressions
                Text("2.1 Operations with Algebraic Expressions")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra-basics/core-algebra-expressions") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra Basics: Algebraic Expressions")
                }
                Spacer()
                //2.2 Rules of Exponents
                Spacer()
                Text("2.2 Rules of Exponents")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra-home/algebra-basics/alg-basics-expressions-with-exponents") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra Basics: Expressions with Exponents")
                }
                
                Spacer()
                //2.3 Solving Linear Equations
                Spacer()
                Text("2.3 Solving Linear Equations")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:solve-equations-inequalities") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: One-variable Linear Equations")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:systems-of-equations") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Systems of Linear Equations")
                }
                
                Spacer()
                //2.4 Solving Quadratic Equations
                Text("2.4 Solving Quadratic Equations")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:quadratic-functions-equations") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Quadratic Equations and Functions")
                }
                Spacer()
                //2.5 Solving Linear Inequalities
                Spacer()
                Text("2.5 Solving Linear Inequalities")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:solve-equations-inequalities/x2f8bb11595b61c86:multistep-inequalities/v/multi-step-inequalities-3") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: One-variable Linear Inequalities")
                }
                Spacer()
                //2.6 Functions
                Spacer()
                Text("2.6 Functions")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:functions") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Functions")
                }
                Spacer()
                //2.7 Applications
                Spacer()
                Text("2.7 Applications")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/pre-algebra/applying-math-reasoning-topic") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Pre-Algebra: Applying Mathematical Reasoning")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:systems-of-equations#x2f8bb11595b61c86:systems-of-equations-word-problems") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Linear Equations and Functions Word Problems")
                }
                Spacer()
                //2.8 Coordinate Geometry
                Spacer()
                Text("2.8 Coordinate Geometry")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:linear-equations-graphs") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Two-variable Linear Equations")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:systems-of-equations") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Systems of Linear Equations")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:inequalities-systems-graphs") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Two-variable Linear Inequalities")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:quadratic-functions-equations") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra I: Quadratic Equations and Functions")
                }
                Spacer()
                //2.9 Graphs of Functions
                Spacer()
                Text("2.9 Graphs of Functions")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra/x2f8bb11595b61c86:quadratic-functions-equations") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Algebra II: Manipulating Functions")
                }
            }
        }
        //ARITHMETIC UNIT POPOVER SCREEN
        .popover(isPresented: $isArithmeticPopoverPresented) {
            VStack(alignment: .leading) {
                Text("\nArithmetic")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                    .background(.purple)
            }
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                //1.1 Integers
                Text("1.1 Integers")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/Arithmetic/multiplication-division") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Multiplication and Division")
                }
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/arithmetic/absolute-value") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Negative Numbers and Absolute Value")
                }
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/pre-algebra/factors-multiples") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Factors and Multiples")
                }
                Spacer()
                //1.2 Fractions
                Spacer()
                Text("1.2 Fractions")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/arithmetic/fractions") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Fractions")
                }
                
                Spacer()
                //1.3 Exponents and Roots
                Spacer()
                Text("1.3 Exponents and Roots")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/pre-algebra/exponents-radicals") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Exponents, Radicals, and Scientific Notation")
                }
                
                Spacer()
                //1.4 Decimals
                Text("1.4 Decimals")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/arithmetic/decimals") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Decimals")
                }
                
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/pre-algebra/order-of-operations") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Arithmetic Properties")
                }
                Spacer()
                //1.5 Real Numbers
                Spacer()
                Text("1.5 Real Numbers")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/arithmetic/absolute-value") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Negative Numbers and Absolute Value")
                }
                
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/algebra-home/pre-algebra/pre-algebra-equations-expressions") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Equations, Expressions, and Inequalities")
                }
                Spacer()
                //1.6 Ratio
                Spacer()
                Text("1.6 Ratio")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/pre-algebra/rates-and-ratios") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Ratios, Proportions, Units, and Rates")
                }
                Spacer()
                //1.7 Percent
                Spacer()
                Text("1.7 Percent")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/arithmetic/decimals") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Decimals")
                }
            }
        }
        //DATA ANALYSIS UNIT POPOVER SCREEN
        .popover(isPresented: $isDataAnalysisPopoverPresented) {
            VStack(alignment: .leading) {
                Text("\nData Analysis")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                    .background(.purple)
            }
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                //4.1 Graphical Methods for Describing Data
                Text("4.1 Graphical Methods for Describing Data")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/pre-algebra/applying-math-reasoning-topic") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Pre-Algebra: Applying mathematical reasoning")
                }
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/cc-eighth-grade-math/cc-8th-data") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("8th Grade: Data and modeling")
                }
                Spacer()
                //4.2 Numerical Methods for Describing Data
                Spacer()
                Text("4.2 Numerical Methods for Describing Data")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/probability/descriptive-statistics") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Prob and Stats: Descriptive Statistics")
                }
                Spacer()
                //4.3 Counting Methods
                Spacer()
                Text("4.3 Counting Methods")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/probability/probability-and-combinatorics-topic") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Prob and Stats: Probability and combinatorics")
                }
                Spacer()
                //4.4 Probability
                Text("4.4 Probability")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/probability/independent-dependent-probability") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Prob and Stats: Independent and dependent events")
                }
                Spacer()
                //4.5 Distributions of Data, Random Variables, and Probability Distributions
                Spacer()
                Text("4.5 Distributions of Data, Random Variables, and Probability Distributions")
                    .font(.custom("Optima-ExtraBlack", size: 22, relativeTo: .title2))
                    .foregroundStyle(.purple)
                Button(action: {
                    if let url = URL(string: "https://www.khanacademy.org/math/statistics-probability/modeling-distributions-of-data") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Prob and Stats: Modeling distributions of data")
                }
                
                Button(action: {
                    if let url = URL(string: "http://www.khanacademy.org/math/probability/random-variables-topic") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Random variables and probability distributions")
                }
            }
        }
    }
    
    #Preview {
        QuantitativeReasoning_CS()
    }
}

/**
*  Ink
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Ink

final class MathTests: XCTestCase {
    func testInlineMath() {
        let html = MarkdownParser().html(from: #"\(Hello \Latex\)"#)
        XCTAssertEqual(html, #"<p><span class="math inline">\(Hello \Latex\)</span></p>"#)
    }
    
    func testDisplayMath() {
        let html = MarkdownParser().html(from: #"\[Hello \Latex\]"#)
        XCTAssertEqual(html, #"<p><span class="math display">\[Hello \Latex\]</span></p>"#)
    }

    func testDisplayStandardFormQuadraticSingleLine() {
        let html = MarkdownParser().html(from: #"\[y = a\left(x-h\right)^2+k\]"#)
        XCTAssertEqual(html, #"<p><span class="math display">\[y = a\left(x-h\right)^2+k\]</span></p>"#)
    }

    func testDisplayStandardFormQuadraticMultiLine() {
        let html = MarkdownParser().html(from: #"""
                                                \[
                                                    y = a\left(x-h\right)^2+k
                                                \]
                                                """#)
        XCTAssertEqual(html, #"""
                                <p><span class="math display">\[
                                    y = a\left(x-h\right)^2+k
                                \]</span></p>
                                """#)
    }

    func testDisplayMultiLineProgression() {
        let html = MarkdownParser().html(from: #"""
                                                \[
                                                y = 5\\
                                                x^2
                                                \]
                                                """#)
        XCTAssertEqual(html, #"""
                                <p><span class="math display">\[
                                y = 5\\
                                x^2
                                \]</span></p>
                                """#)
    }

    func testDisplayMultiLineAlignedEquationProgression() {
        let html = MarkdownParser().html(from: #"""
                                                \[
                                                \begin{aligned}
                                                y&=\left(x-r\right)\left(x-s\right)\\
                                                y&=\left(x-\left(-7\right)\right)\left(x-\left(-2\right)\right)\\
                                                y&=\left(x+7\right)\left(x+2\right)\\
                                                y&=x^2+9x+14\\
                                                y&=x^2+bx+c\\
                                                \end{aligned}
                                                \]
                                                """#)
        XCTAssertEqual(html, #"""
                                <p><span class="math display">\[
                                \begin{aligned}
                                y&=\left(x-r\right)\left(x-s\right)\\
                                y&=\left(x-\left(-7\right)\right)\left(x-\left(-2\right)\right)\\
                                y&=\left(x+7\right)\left(x+2\right)\\
                                y&=x^2+9x+14\\
                                y&=x^2+bx+c\\
                                \end{aligned}
                                \]</span></p>
                                """#)
    }

    func testMathWithEscape() {
        let html = MarkdownParser().html(from: #"Asterix \* and \(Hello \Latex\)"#)
        XCTAssertEqual(html, #"<p>Asterix * and <span class="math inline">\(Hello \Latex\)</span></p>"#)
    }
}

extension MathTests {
    static var allTests: Linux.TestList<MathTests> {
        return [
            ("testInlineMath", testInlineMath),
            ("testDisplayMath", testDisplayMath),
            ("testDisplayStandardFormQuadraticSingleLine", testDisplayStandardFormQuadraticSingleLine),
            ("testDisplayStandardFormQuadraticMultiLine", testDisplayStandardFormQuadraticMultiLine),
            ("testDisplayMultiLineProgression", testDisplayMultiLineProgression),
            ("testDisplayMultiLineAlignedEquationProgression", testDisplayMultiLineAlignedEquationProgression),
            ("testMathWithEscape", testMathWithEscape),
        ]
    }
}

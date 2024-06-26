describe('Header', () => {
  beforeEach(() => {
    cy.visit('https://resume-dev.northof66.com')
  })
  it('has header information', () => {
    cy.title().should('include', 'Resume')
  })
  it('has a left sidebar', () => {
    cy.get('.left')
      .should('have.class', 'left')
      
  })
  it('has a header', () => {
    cy.contains('Rhyss Vivian')
  })
})
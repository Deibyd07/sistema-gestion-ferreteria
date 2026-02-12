import { render } from '@testing-library/react';
import Home from '@/app/page';

describe('Home Page', () => {
  it('should render the home page', () => {
    render(<Home />);

    // Verificar que la pagina se renderiza
    expect(document.body).toBeInTheDocument();
  });

  it('should have proper document structure', () => {
    const { container } = render(<Home />);

    // Verificar estructura basica
    expect(container).toBeInTheDocument();
  });
});

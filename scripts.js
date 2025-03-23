// Resaltar la sección activa en la navegación
const sections = document.querySelectorAll('section');
const navLinks = document.querySelectorAll('#navegacion a');

window.addEventListener('scroll', () => {
    let current = '';
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        if (pageYOffset >= sectionTop - sectionHeight / 3) {
            current = section.getAttribute('id');
        }
    });

    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href').includes(current)) {
            link.classList.add('active');
        }
    });
});

// Animación al cargar la página
document.addEventListener('DOMContentLoaded', () => {
    const sections = document.querySelectorAll('section');
    sections.forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
    });

    setTimeout(() => {
        sections.forEach((section, index) => {
            setTimeout(() => {
                section.style.opacity = '1';
                section.style.transform = 'translateY(0)';
                section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            }, index * 200); // Retraso entre secciones
        });
    }, 500); // Retraso inicial
});

// Botón para volver al inicio
const backToTopButton = document.createElement('button');
backToTopButton.innerHTML = '↑';
backToTopButton.id = 'back-to-top';
document.body.appendChild(backToTopButton);

backToTopButton.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

window.addEventListener('scroll', () => {
    if (window.pageYOffset > 300) {
        backToTopButton.style.display = 'block';
    } else {
        backToTopButton.style.display = 'none';
    }
});


// Animación de las barras de habilidades al aparecer
const habilidadesSection = document.getElementById('habilidades');
const barras = document.querySelectorAll('.progreso');

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            barras.forEach(barra => {
                barra.style.width = barra.getAttribute('data-progress');
            });
            observer.unobserve(habilidadesSection); // Dejar de observar
        }
    });
}, { threshold: 0.5 });

observer.observe(habilidadesSection);
// translations.js (o podrías pegarlo directamente en script.js)
const translations = {
    en: {
        language: "Languages",
        theme: "Themes mode",
        title: "Testing Bootstrap with this page.",
        desc: "This is a simple AI page with Bootstrap.",
        btn: "Click Me!",
        merienda: "Snack",
        elemento2: "Element 2",
        ambos: "Both",
        modal1title: "Let's prepare this dish!",
        modal1msg: "You clicked the button!",
        close: "Close",
        openLongModal: "Open Modal with Long Content",
        modal2title: "Modal Title",
        save: "Save changes",
        modal2content: "Modal content...",
        merienda3: "Snack 3",
        elemento4: "Element 4" // Nueva clave de traducción
    },
    es: {
        language: "Idiomas",
        theme: "Modo de tema",
        title: "Probando Bootstrap con esta página.",
        desc: "Esta es una página simple de IA con Bootstrap.",
        btn: "¡Haz clic!",
        merienda: "Merienda",
        elemento2: "Elemento 2",
        ambos: "Ambos",
        modal1title: "¡Preparemos este plato!",
        modal1msg: "¡Has hecho clic en el botón!",
        close: "Cerrar",
        openLongModal: "Abrir Modal con Contenido Largo",
        modal2title: "Título del Modal",
        save: "Guardar cambios",
        modal2content: "Contenido del modal...",
        merienda3: "Merienda 3",
        elemento4: "Elemento 4"
    },
    fr: {
        language: "Langues",
        theme: "Mode thème",
        title: "Tester Bootstrap avec cette page.",
        desc: "Ceci est une page IA simple avec Bootstrap.",
        btn: "Cliquez-moi!",
        merienda: "Goûter",
        elemento2: "Élément 2",
        ambos: "Les deux",
        modal1title: "Préparons ce plat!",
        modal1msg: "Vous avez cliqué sur le bouton!",
        close: "Fermer",
        openLongModal: "Ouvrir le modal avec contenu long",
        modal2title: "Titre du Modal",
        save: "Enregistrer les modifications",
        modal2content: "Contenu du modal...",
        merienda3: "Goûter 3",
        elemento4: "Élément 4"
    }
};

// Función para aplicar las traducciones
function applyTranslations(lang) {
    // Establecer el atributo lang en la etiqueta <html>
    document.documentElement.lang = lang;

    // Actualizar el texto de todos los elementos que tienen el atributo data-translate-key
    document.querySelectorAll('[data-translate-key]').forEach(element => {
        const key = element.getAttribute('data-translate-key');
        if (translations[lang] && translations[lang][key]) {
            // Se usa textContent para elementos que tienen solo texto.
            // Para inputs o otros elementos con atributos, se manejaría diferente.
            element.textContent = translations[lang][key];
        }
    });

    // Generar el contenido dinámico del modal largo
    const modalBodyContainer = document.querySelector('[data-translate-container="modal2content"]');
    if (modalBodyContainer) {
        modalBodyContainer.innerHTML = ""; // Limpiar el contenido actual
        for (let i = 0; i < 10; i++) {
            const p = document.createElement("p");
            p.textContent = translations[lang].modal2content;
            modalBodyContainer.appendChild(p);
        }
    }

    // Guardar el idioma seleccionado en el almacenamiento local
    localStorage.setItem('selectedLanguage', lang);
}

// Función para establecer el tema
function setTheme(theme) {
    document.documentElement.setAttribute('data-bs-theme', theme);
    // Guardar el tema seleccionado en el almacenamiento local
    localStorage.setItem('selectedTheme', theme);
}

// Event Listeners para los selectores de idioma y tema
document.addEventListener('DOMContentLoaded', () => {
    // Restaurar el idioma guardado o usar 'es' por defecto
    const savedLang = localStorage.getItem('selectedLanguage') || 'es';
    applyTranslations(savedLang);

    // Restaurar el tema guardado o usar 'light' por defecto
    const savedTheme = localStorage.getItem('selectedTheme') || 'light';
    setTheme(savedTheme);

    // Adjuntar event listeners a los elementos del dropdown de idiomas
    // Se usa un selector más específico para evitar conflictos si hubiera otros dropdowns
    document.querySelectorAll('#dropdownMenuButtonLanguages + .dropdown-menu .dropdown-item').forEach(item => {
        item.addEventListener('click', (event) => {
            event.preventDefault(); // Evitar el comportamiento predeterminado del enlace
            const lang = event.target.getAttribute('data-lang');
            if (lang) {
                applyTranslations(lang);
            }
        });
    });

    // Adjuntar event listeners a los elementos del dropdown de temas
    document.querySelectorAll('#dropdownMenuButtonThemes + .dropdown-menu .dropdown-item').forEach(item => {
        item.addEventListener('click', (event) => {
            event.preventDefault(); // Evitar el comportamiento predeterminado del enlace
            const theme = event.target.getAttribute('data-theme');
            if (theme) {
                setTheme(theme);
            }
        });
    });
});
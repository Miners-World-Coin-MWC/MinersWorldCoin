#include <qt/guiutil.h>
#include <QApplication>

namespace GUIUtil {

void ApplyMWCTheme(bool dark)
{
    if (dark) {
        qApp->setStyleSheet(R"(
/* =========================
   MWC DARK MODE (FINAL)
========================= */

* {
    font-family: "Segoe UI", "Inter", "Arial";
}

/* ---------- Base ---------- */
QMainWindow,
QDialog,
QWidget {
    background-color: #0b0f14;
    color: #e5e7eb;
}

/* ---------- Universal readable text ---------- */
QLabel,
QAbstractItemView,
QTextEdit,
QPlainTextEdit,
QTextBrowser {
    color: #e5e7eb;
    background-color: transparent;
}

/* ---------- Scroll / About dialog fix ---------- */
QScrollArea,
QScrollArea QWidget,
QScrollArea::viewport {
    background-color: #0b0f14;
    color: #e5e7eb;
    border: none;
}

/* ---------- Debug / info panels ---------- */
QTextBrowser {
    background-color: #0b0f14;
    border: 1px solid #1f2937;
    border-radius: 6px;
}

/* ---------- Menus / bars ---------- */
QMenuBar, QMenu, QToolBar, QStatusBar {
    background-color: #0e141c;
    color: #e5e7eb;
}

QMenu::item {
    background-color: transparent;
    color: #e5e7eb;
    padding: 6px 20px;
}

QMenu::item:selected {
    background-color: #121821;
    color: #f59e0b;
}

QMenu::item:disabled {
    color: #6b7280;
}

/* ---------- Inputs ---------- */
QLineEdit, QTextEdit, QPlainTextEdit, QSpinBox, QComboBox {
    background-color: #0b0f14;
    border: 1px solid #1f2937;
    border-radius: 4px;
    color: #e5e7eb;
    selection-background-color: #f59e0b;
    selection-color: #020617;
}

QLineEdit:focus,
QTextEdit:focus,
QPlainTextEdit:focus {
    border-color: #f59e0b;
}

/* ---------- Buttons ---------- */
QPushButton {
    background-color: #121821;
    border: 1px solid #1f2937;
    border-radius: 6px;
    padding: 6px 12px;
    color: #e5e7eb;
}

QPushButton:hover {
    background-color: #1a2230;
    border-color: #f59e0b;
    box-shadow: 0 0 6px rgba(245,158,11,0.35);
}

/* ---------- Checkboxes / radios ---------- */
QCheckBox, QRadioButton {
    color: #e5e7eb;
}

QCheckBox::indicator,
QRadioButton::indicator {
    width: 16px;
    height: 16px;
}

QCheckBox::indicator:checked,
QRadioButton::indicator:checked {
    background-color: #f59e0b;
    border: 1px solid #fbbf24;
}

/* ---------- Progress ---------- */
QProgressBar {
    background-color: #0e141c;
    border: 1px solid #1f2937;
    border-radius: 4px;
    color: #e5e7eb;
}

QProgressBar::chunk {
    background-color: #f59e0b;
    border-radius: 3px;
}

/* ---------- Tables ---------- */
QTableView, QTreeView {
    background-color: #0b0f14;
    alternate-background-color: #121821;
    gridline-color: #1f2937;
    color: #e5e7eb;
}

QTableView::item:selected,
QTreeView::item:selected {
    background-color: #1a2230;
    color: #f59e0b;
}

/* ---------- Headers ---------- */
QHeaderView::section {
    background-color: #0e141c;
    border: 1px solid #1f2937;
    padding: 6px;
    color: #f59e0b;
}

/* ---------- Tabs ---------- */
QTabWidget::pane {
    background-color: #0b0f14;
    border: 1px solid #1f2937;
    border-radius: 6px;
}

QTabBar::tab {
    background-color: #0e141c;
    border: 1px solid #1f2937;
    padding: 8px 14px;
    color: #9ca3af;
    border-radius: 6px;
    margin-right: 4px;
}

QTabBar::tab:hover {
    color: #fbbf24;
    border-color: #f59e0b;
    box-shadow: 0 0 8px rgba(245,158,11,0.45);
}

QTabBar::tab:selected {
    background-color: #121821;
    color: #f59e0b;
    border-bottom: 2px solid #f59e0b;
    box-shadow: 0 0 10px rgba(245,158,11,0.45);
}

/* ---------- Cards ONLY ---------- */
QGroupBox {
    background-color: #121821;
    border: 1px solid #1f2937;
    border-radius: 8px;
    margin-top: 8px;
}

QGroupBox::title {
    color: #f59e0b;
}

/* ---------- Disabled ---------- */
QLabel:disabled {
    color: #9ca3af;
}
)");
    } else {
        qApp->setStyleSheet(R"(
/* =========================
   MWC LIGHT MODE (CLEAN)
========================= */

QMainWindow,
QDialog {
    background-color: #f8fafc;
    color: #020617;
    font-family: "Segoe UI", "Inter", "Arial";
}

QLabel,
QAbstractItemView,
QTextEdit,
QPlainTextEdit,
QTextBrowser {
    color: #020617;
    background-color: transparent;
}

QMenuBar, QMenu, QToolBar, QStatusBar {
    background-color: #f1f5f9;
    color: #020617;
}

QMenu::item:selected {
    background-color: #ffffff;
    color: #d97706;
}

QLineEdit, QTextEdit, QPlainTextEdit {
    background-color: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 4px;
    color: #020617;
    selection-background-color: #f59e0b;
}

QPushButton {
    background-color: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    padding: 6px 12px;
    color: #020617;
}

QPushButton:hover {
    border-color: #d97706;
    background-color: #f1f5f9;
}

QTabBar::tab {
    background-color: #f1f5f9;
    border: 1px solid #e5e7eb;
    padding: 8px 14px;
    color: #475569;
    border-radius: 6px;
}

QTabBar::tab:selected {
    color: #d97706;
    border-bottom: 2px solid #d97706;
}

QGroupBox {
    background-color: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
}

QHeaderView::section {
    background-color: #f1f5f9;
    border: 1px solid #e5e7eb;
    color: #d97706;
}

QLabel:disabled {
    color: #475569;
}
)");
    }
}

} // namespace GUIUtil

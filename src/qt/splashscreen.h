#ifndef BITCOIN_QT_SPLASHSCREEN_H
#define BITCOIN_QT_SPLASHSCREEN_H

#include <functional>
#include <QSplashScreen>
#include <boost/signals2/connection.hpp>

class CWallet;
class NetworkStyle;

/** Class for the splashscreen with information of the running client.
 *
 * @note this is intentionally not a QSplashScreen. Bitcoin Core initialization
 * can take a long time, and in that case a progress window that cannot be
 * moved around and minimized has turned out to be frustrating to the user.
 */
class SplashScreen : public QWidget
{
    Q_OBJECT

public:
    explicit SplashScreen(Qt::WindowFlags f, const NetworkStyle *networkStyle);
    ~SplashScreen();

protected:
    void paintEvent(QPaintEvent *event);
    void closeEvent(QCloseEvent *event);

public Q_SLOTS:
    /** Slot to call finish() method as it's not defined as slot */
    void slotFinish(QWidget *mainWin);

    /** Show message and progress */
    void showMessage(const QString &message, int alignment, const QColor &color);

protected:
    bool eventFilter(QObject * obj, QEvent * ev);

private:
    /** Connect core signals to splash screen */
    void subscribeToCoreSignals();
    /** Disconnect core signals from splash screen */
    void unsubscribeFromCoreSignals();
    /** Connect wallet signals to splash screen */
    void ConnectWallet(CWallet*);

    QPixmap pixmap;
    QString curMessage;
    QColor curColor;
    int curAlignment;

    QList<CWallet*> connectedWallets;

    // 🔧 These are required for tracking signal connections
    boost::signals2::connection initMessageConnection;
    boost::signals2::connection showProgressConnection;
#ifdef ENABLE_WALLET
    boost::signals2::connection loadWalletConnection;
#endif
};

#endif // BITCOIN_QT_SPLASHSCREEN_H

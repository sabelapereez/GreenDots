package com.example.impacthon.ui.map

import android.graphics.Bitmap
import android.net.Uri
import android.view.LayoutInflater
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Spinner
import android.widget.Toast
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.draggable
import androidx.compose.foundation.gestures.rememberDraggableState
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Card
import androidx.compose.material.Divider
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Slider
import androidx.compose.material.SliderDefaults
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.res.vectorResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.compose.ui.window.Dialog
import coil.compose.rememberAsyncImagePainter
import com.example.impacthon.R
import com.example.impacthon.backend.api.RetrofitClient
import com.example.impacthon.backend.models.Local
import com.example.impacthon.backend.models.LocalForOpinion
import com.example.impacthon.backend.models.Opinion
import com.example.impacthon.backend.models.UsuarioForOpinion
import com.example.impacthon.utils.AuxUtils
import com.example.impacthon.utils.MapUtils
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.io.ByteArrayOutputStream
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

class MapComponents {
    @Composable
    fun MarkerInfoSheet(
        local: Local,
        resolvedAddress: String?,
        onClose: () -> Unit,
        onAddOpinion: () -> Unit) {
        var showOpinionsDialog by remember { mutableStateOf(false) }
        var opinionesList by remember { mutableStateOf<List<Opinion>>(emptyList()) }
        val context = LocalContext.current
        var spacerHeight by remember { mutableStateOf(0.6f) }

        Column {
            Spacer(
                modifier = Modifier.fillMaxHeight(spacerHeight)
            )
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .fillMaxHeight()
                    .background(MaterialTheme.colors.surface)
                    .padding(bottom = 72.dp)
                    .draggable(
                        orientation = Orientation.Vertical,
                        state = rememberDraggableState { delta ->
                            spacerHeight = (spacerHeight + delta / 1000).coerceIn(0.3f, 0.85f)
                        }
                    )
            ) {
                Column(modifier = Modifier.fillMaxSize()) {
                    // Título y botón de cierre
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 20.dp),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = stringResource(id = R.string.title_place_information),
                            style = MaterialTheme.typography.h6,
                        )
                        IconButton(onClick = { onClose() }) {
                            Icon(
                                imageVector = Icons.Default.Close,
                                contentDescription = "Cerrar"
                            )
                        }
                    }
                    Divider()

                    // Aquí los botones de las opiniones, ahora arriba
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(top = 16.dp),
                        horizontalArrangement = Arrangement.SpaceEvenly
                    ) {
                        Button(
                            onClick = onAddOpinion,
                            colors = ButtonDefaults.buttonColors(
                                backgroundColor = colorResource(R.color.green500),
                                contentColor = colorResource(R.color.white)
                            )
                        ) {
                            Text(stringResource(id = R.string.add_opinion_buton))
                        }
                        Button(
                            onClick = {
                                opinionesList = emptyList()
                                RetrofitClient.instance.getOpinionesPorLocal(local.id)
                                    .enqueue(object : Callback<List<Opinion>> {
                                        override fun onResponse(
                                            call: Call<List<Opinion>>,
                                            response: Response<List<Opinion>>
                                        ) {
                                            if (response.isSuccessful) {
                                                opinionesList = response.body() ?: emptyList()
                                                showOpinionsDialog = true
                                            } else {
                                                Toast.makeText(
                                                    context,
                                                    R.string.text_no_opinions,
                                                    Toast.LENGTH_SHORT
                                                ).show()
                                            }
                                        }

                                        override fun onFailure(
                                            call: Call<List<Opinion>>,
                                            t: Throwable
                                        ) {
                                            Toast.makeText(
                                                context,
                                                "Fallo en la petición: ${t.message}",
                                                Toast.LENGTH_SHORT
                                            ).show()
                                        }
                                    })
                            },
                            colors = ButtonDefaults.buttonColors(
                                backgroundColor = colorResource(R.color.green500),
                                contentColor = colorResource(R.color.white)
                            )
                        ) {
                            Text(stringResource(id = R.string.show_opinions_button))
                        }
                    }
                    // Insertamos las InfoCards
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .verticalScroll(rememberScrollState()) // Permite desplazarse si hay mucho contenido
                            .padding(8.dp)
                    ) {
                        InfoCard(
                            nombre = local.nombre,
                            categoria = local.categoria,
                            direccion = resolvedAddress,
                            ecosostenible = local.ecosostenible,
                            accesibilidad = local.accesibilidad,
                            inclusion_social = local.inclusionSocial
                        )
                    }
                }

                // Mostrar el diálogo de opiniones si se activa
                if (showOpinionsDialog) {
                    Dialog(onDismissRequest = { showOpinionsDialog = false }) {
                        Card(
                            elevation = 18.dp,
                            shape = MaterialTheme.shapes.medium,
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(16.dp)
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .fillMaxHeight(0.9f)
                                    .padding(16.dp)
                            ) {
                                // Header fijo
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween,
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Text(
                                        text = stringResource(id = R.string.title_local_opinions),
                                        style = MaterialTheme.typography.h5.copy(fontWeight = FontWeight.Bold)
                                    )
                                    IconButton(onClick = { showOpinionsDialog = false }) {
                                        Icon(
                                            imageVector = Icons.Default.Close,
                                            contentDescription = "Cerrar"
                                        )
                                    }
                                }
                                Divider()
                                Spacer(modifier = Modifier.height(8.dp))

                                // Lista scrollable de opiniones
                                Box(modifier = Modifier.weight(1f)) {
                                    LazyColumn(
                                        modifier = Modifier.fillMaxSize(),
                                        state = rememberLazyListState()
                                    ) {
                                        if (opinionesList.isEmpty()) {
                                            item {
                                                Text(
                                                    text = stringResource(id = R.string.text_no_opinions),
                                                    modifier = Modifier.padding(8.dp)
                                                )
                                            }
                                        } else {
                                            items(opinionesList) { opinion ->
                                                // Aquí se coloca la UI de cada opinión (tal y como la tienes actualmente)
                                                    Column(modifier = Modifier.padding(vertical = 8.dp)) {
                                                        Row(verticalAlignment = Alignment.CenterVertically) {
                                                            val painter = remember { mutableStateOf<Any>(R.mipmap.logo_app_redondo) }
                                                            val isImageLoaded = remember { mutableStateOf(false) }

                                                            if (!isImageLoaded.value) {
                                                                MapUtils.fetchUser(opinion.usuario.nickname) { usuario ->
                                                                    usuario?.fotoPerfil?.let { base64Image ->
                                                                        AuxUtils.decodeBase64ToBitmap(base64Image)?.let { bitmap ->
                                                                            painter.value = bitmap
                                                                            isImageLoaded.value = true
                                                                        }
                                                                    }
                                                                }
                                                            }

                                                            Image(
                                                                painter = rememberAsyncImagePainter(model = painter.value),
                                                                contentDescription = null,
                                                                modifier = Modifier
                                                                    .size(36.dp)
                                                                    .clip(CircleShape)
                                                                    .background(MaterialTheme.colors.onSurface)
                                                            )

                                                            Spacer(modifier = Modifier.width(8.dp))

                                                            Text(
                                                                text = opinion.usuario.nickname,
                                                                style = MaterialTheme.typography.h6.copy(fontWeight = FontWeight.Bold)
                                                            )
                                                        }

                                                        Spacer(modifier = Modifier.height(8.dp))
                                                        Text(
                                                            text = opinion.resenaTexto,
                                                            style = MaterialTheme.typography.subtitle1
                                                        )
                                                        // Mostrar las valoraciones con estrellas
                                                        Column {
                                                            AddRatingWithStars(
                                                                stringResource(id = R.string.title_ecosustainable),
                                                                opinion.ecosostenible
                                                            )
                                                            AddRatingWithStars(
                                                                stringResource(id = R.string.title_socialinclusion),
                                                                opinion.inclusionSocial
                                                            )
                                                            AddRatingWithStars(
                                                                stringResource(id = R.string.title_accessibility),
                                                                opinion.accesibilidad
                                                            )
                                                        }
                                                        Spacer(modifier = Modifier.height(8.dp))

                                                        // Mostrar la imagen de la opinión si existe
                                                        if (!opinion.foto.isNullOrEmpty()) {
                                                            val decodedImage = AuxUtils.decodeBase64ToBitmap(opinion.foto)
                                                            decodedImage?.let {
                                                                Image(
                                                                    bitmap = it.asImageBitmap(),
                                                                    contentDescription = null,
                                                                    modifier = Modifier
                                                                        .fillMaxWidth()
                                                                        .height(200.dp)
                                                                        .clip(MaterialTheme.shapes.medium)
                                                                )
                                                                Spacer(modifier = Modifier.height(8.dp))
                                                            }
                                                        }
                                                        Text(
                                                            text = AuxUtils.formatDate(opinion.fechaPublicacion),
                                                            style = MaterialTheme.typography.body2,
                                                            modifier = Modifier
                                                                .padding(vertical = 4.dp)
                                                                .fillMaxWidth(),
                                                            textAlign = TextAlign.End
                                                        )
                                                        Divider(modifier = Modifier.padding(vertical = 8.dp))
                                                    }
                                            }
                                        }
                                    }
                                }

                                Spacer(modifier = Modifier.height(8.dp))
                                // Botón de cierre fijo en el pie
                                Button(
                                    onClick = { showOpinionsDialog = false },
                                    modifier = Modifier.align(Alignment.CenterHorizontally),
                                    colors = ButtonDefaults.buttonColors(
                                        backgroundColor = colorResource(R.color.green500),
                                        contentColor = colorResource(R.color.white)
                                    )
                                ) {
                                    Text(text = stringResource(id = R.string.title_close))
                                }
                            }
                        }
                    }
                }


            }
        }
    }

    @Composable
    private fun AddRatingWithStars(label: String, rating: Int, bold: Boolean = false) {
        Row(modifier = Modifier.padding(vertical = 4.dp)) {
            Text(
                text = label,
                style = if (bold) MaterialTheme.typography.body2.copy(fontWeight = FontWeight.Bold) else MaterialTheme.typography.body2,
                modifier = Modifier.weight(1f)
            )
            Row {
                for (i in 1..5) {
                    Icon(
                        imageVector = if (i <= rating) ImageVector.vectorResource(id = R.drawable.star_filled_24dp) else ImageVector.vectorResource(id = R.drawable.star_empty_24dp),
                        contentDescription = null,
                        tint = colorResource(id = R.color.green500)
                    )
                }
            }
        }
    }

    @Composable
    fun InfoCard(
        nombre: String,
        categoria: String,
        direccion: String?,
        ecosostenible: Int,
        accesibilidad: Int,
        inclusion_social: Int
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp) // Espacio entre tarjetas
        ) {
            // Tarjeta de Nombre
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                elevation = 6.dp,
                backgroundColor = colorResource(id = R.color.white)
            ) {
                Row(
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .fillMaxSize(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text(
                        text = String.format("%s:", stringResource(id = R.string.title_name)),
                        style = MaterialTheme.typography.subtitle2.copy(fontWeight = FontWeight.Bold),
                        color = colorResource(id = R.color.black),
                        modifier = Modifier.weight(0.3f)
                    )
                    Text(
                        text = nombre,
                        style = MaterialTheme.typography.body2,
                        color = colorResource(id = R.color.black),
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        modifier = Modifier.weight(0.7f)
                    )
                }
            }

            // Tarjeta de Categoría
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                elevation = 6.dp,
                backgroundColor = colorResource(id = R.color.white)
            ) {
                Row(
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .fillMaxSize(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text(
                        text = String.format("%s:", stringResource(id = R.string.title_category)),
                        style = MaterialTheme.typography.subtitle2.copy(fontWeight = FontWeight.Bold),
                        color = colorResource(id = R.color.black),
                        modifier = Modifier.weight(0.3f)
                    )
                    Text(
                        text = categoria,
                        style = MaterialTheme.typography.body2,
                        color = colorResource(id = R.color.black),
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        modifier = Modifier.weight(0.7f)
                    )
                }
            }

            // Tarjeta de Ubicación
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                elevation = 6.dp,
                backgroundColor = colorResource(id = R.color.white)
            ) {
                Row(
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .fillMaxSize(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text(
                        text = String.format("%s:", stringResource(id = R.string.title_location)),
                        style = MaterialTheme.typography.subtitle2.copy(fontWeight = FontWeight.Bold),
                        color = colorResource(id = R.color.black),
                        modifier = Modifier.weight(0.3f)
                    )
                    Text(
                        text = direccion.toString(),
                        style = MaterialTheme.typography.body2,
                        color = colorResource(id = R.color.black),
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        modifier = Modifier.weight(0.7f)
                    )
                }
            }

            // Tarjeta de Ecosostenible
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                elevation = 6.dp,
                backgroundColor = colorResource(id = R.color.white)
            ) {
                Row(
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .fillMaxSize(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Mostrar la valoración de ecosostenible como estrellas
                    AddRatingWithStars(label = stringResource(id = R.string.title_ecosustainable), rating = ecosostenible, true)
                }
            }

            // Tarjeta de Accesibilidad
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                elevation = 6.dp,
                backgroundColor = colorResource(id = R.color.white)
            ) {
                Row(
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .fillMaxSize(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Mostrar la valoración de accesibilidad como estrellas
                    AddRatingWithStars(label = stringResource(id = R.string.title_accessibility), rating = accesibilidad, true)
                }
            }

            // Tarjeta de Inclusión Social
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                elevation = 6.dp,
                backgroundColor = colorResource(id = R.color.white)
            ) {
                Row(
                    modifier = Modifier
                        .padding(horizontal = 16.dp, vertical = 8.dp)
                        .fillMaxSize(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    // Mostrar la valoración de inclusión social como estrellas
                    AddRatingWithStars(label = stringResource(id = R.string.title_socialinclusion), rating = inclusion_social, true)
                }
            }

        }
    }

    @Composable
    fun SearchBarDropdown(
        modifier: Modifier = Modifier,
        onCitySelected: (String) -> Unit
    ) {
        AndroidView(
            factory = { context ->
                LayoutInflater.from(context).inflate(R.layout.search_bar, null, false).apply {
                    val spinner = findViewById<Spinner>(R.id.city_spinner)
                    val cities = context.resources.getStringArray(R.array.cities_array).toMutableList()

                    cities.add(0, context.getString(R.string.select_city))
                    // Crea un ArrayAdapter con un layout personalizado para el ítem seleccionado
                    val adapter = ArrayAdapter(context, R.layout.spinner_items, cities).apply {
                        // Establece el layout para los ítems desplegados
                        setDropDownViewResource(R.layout.spinner_items)
                    }
                    spinner.adapter = adapter

                    spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                        override fun onItemSelected(
                            parent: AdapterView<*>?,
                            view: View?,
                            position: Int,
                            id: Long
                        ) {
                            if (position > 0) {
                                val city = parent?.getItemAtPosition(position) as String
                                onCitySelected(city)

                                // Restablecer la selección a la opción por defecto
                                (parent as? Spinner)?.setSelection(0)
                            }
                        }
                        override fun onNothingSelected(parent: AdapterView<*>?) { }
                    }
                }
            },
            modifier = modifier
        )
    }

    @Composable
    fun NewOpinionFormDialog(mapViewModel: MapViewModel, local: Local, onDismiss: () -> Unit) {
        var reviewText by remember { mutableStateOf("") }
        var ecosostenible by remember { mutableStateOf(0f) }
        var inclusionSocial by remember { mutableStateOf(0f) }
        var accesibilidad by remember { mutableStateOf(0f) }
        val context = LocalContext.current
        val nickname = mapViewModel.nicknameUsuario()

        // Estado para mostrar el diálogo de selección de fuente de imagen
        var showImageSourceDialog by remember { mutableStateOf(false) }
        // Estado para almacenar la imagen seleccionada como ByteArray
        var selectedImageByteArray by remember { mutableStateOf<ByteArray?>(null) }

        // Launcher para capturar imagen desde la cámara (preview)
        val cameraLauncher = rememberLauncherForActivityResult(
            contract = ActivityResultContracts.TakePicturePreview()
        ) { bitmap: Bitmap? ->
            bitmap?.let {
                val outputStream = ByteArrayOutputStream()
                it.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
                selectedImageByteArray = outputStream.toByteArray()
            }
        }

        // Launcher para seleccionar imagen desde la galería
        val galleryLauncher = rememberLauncherForActivityResult(
            contract = ActivityResultContracts.GetContent()
        ) { uri: Uri? ->
            uri?.let {
                // Lee el contenido del Uri y lo guarda en un ByteArray
                context.contentResolver.openInputStream(it)?.use { inputStream ->
                    selectedImageByteArray = inputStream.readBytes()
                }
            }
        }

        // Función para convertir el ByteArray a Base64 (si es necesario enviarlo como string)
        fun byteArrayToBase64(bytes: ByteArray): String {
            return android.util.Base64.encodeToString(bytes, android.util.Base64.DEFAULT)
        }

        // Genera la fecha actual en formato ISO, por ejemplo "2025-03-12T12:30:00.000+0000"
        val formattedDate = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ", Locale.getDefault()).format(
            Date()
        )

        // Diálogo para elegir la fuente de la imagen
        if (showImageSourceDialog) {
            AlertDialog(
                onDismissRequest = { showImageSourceDialog = false },
                title = { Text("Selecciona Fuente de Imagen") },
                text = { Text("Elige entre tomar una foto o seleccionar desde la galería") },
                confirmButton = {
                    Button(
                        onClick = {
                            showImageSourceDialog = false
                            cameraLauncher.launch(null) // Abre la cámara
                        },
                        colors = ButtonDefaults.buttonColors(
                            backgroundColor = colorResource(R.color.green500),
                            contentColor = colorResource(R.color.white)
                        )
                    ) {
                        Text("Cámara")
                    }
                },
                dismissButton = {
                    Button(
                        onClick = {
                            showImageSourceDialog = false
                            galleryLauncher.launch("image/*") // Abre la galería
                        },
                        colors = ButtonDefaults.buttonColors(
                            backgroundColor = colorResource(R.color.green500),
                            contentColor = colorResource(R.color.white)
                        )
                    ) {
                        Text("Galería")
                    }
                }
            )
        }

        AlertDialog(
            onDismissRequest = onDismiss,
            title = { Text(stringResource(id = R.string.add_opinion_buton)) },
            text = {
                Column {
                    OutlinedTextField(
                        value = reviewText,
                        onValueChange = { reviewText = it },
                        label = { Text(stringResource(id = R.string.title_opinion)) },
                        modifier = Modifier.fillMaxWidth()
                    )
                    Spacer(modifier = Modifier.height(8.dp))

                    Text(text = "${stringResource(id = R.string.title_ecosustainable)}: ${ecosostenible.toInt()}")
                    Slider(
                        value = ecosostenible,
                        onValueChange = { ecosostenible = it },
                        valueRange = 0f..5f,
                        steps = 4,
                        colors = SliderDefaults.colors(
                            thumbColor = colorResource(id = R.color.green500),
                            activeTrackColor = colorResource(id = R.color.green500),
                            inactiveTrackColor = colorResource(id = R.color.darkgreen900)
                        )
                    )

                    Text(text = "${stringResource(id = R.string.title_socialinclusion)}: ${inclusionSocial.toInt()}")
                    Slider(
                        value = inclusionSocial,
                        onValueChange = { inclusionSocial = it },
                        valueRange = 0f..5f,
                        steps = 4,
                        colors = SliderDefaults.colors(
                            thumbColor = colorResource(id = R.color.green500),
                            activeTrackColor = colorResource(id = R.color.green500),
                            inactiveTrackColor = colorResource(id = R.color.darkgreen900)
                        )
                    )

                    Text(text = "${stringResource(id = R.string.title_accessibility)}: ${accesibilidad.toInt()}")
                    Slider(
                        value = accesibilidad,
                        onValueChange = { accesibilidad = it },
                        valueRange = 0f..5f,
                        steps = 4,
                        colors = SliderDefaults.colors(
                            thumbColor = colorResource(id = R.color.green500),
                            activeTrackColor = colorResource(id = R.color.green500),
                            inactiveTrackColor = colorResource(id = R.color.darkgreen900)
                        )
                    )

                    Spacer(modifier = Modifier.height(8.dp))
                    // Botón único para añadir foto
                    Button(
                        onClick = { showImageSourceDialog = true },
                        colors = ButtonDefaults.buttonColors(
                            backgroundColor = colorResource(R.color.green500),
                            contentColor = colorResource(R.color.white)
                        )
                    ) {
                        Text(stringResource(id = R.string.add_photo_button))
                    }
                    Spacer(modifier = Modifier.height(8.dp))
                    // Muestra un mensaje simple según si se ha seleccionado una imagen
                    if (selectedImageByteArray != null) {
                        Text("Imagen seleccionada (${selectedImageByteArray!!.size} bytes)")
                    }
                }
            },
            confirmButton = {
                Button(
                    onClick = {
                        // Se convierte el ByteArray a Base64 y se guarda en la lista de fotos (si se seleccionó imagen)
                        val fotosList = if (selectedImageByteArray != null) byteArrayToBase64(selectedImageByteArray!!) else ""

                        val newOpinion = Opinion(
                            id = 0, // El backend generará el id
                            usuario = UsuarioForOpinion(nickname = nickname ?: "Desconocido"),
                            local = LocalForOpinion(id = local.id),
                            fechaPublicacion = formattedDate,
                            resenaTexto = reviewText,
                            ecosostenible = ecosostenible.toInt(),
                            inclusionSocial = inclusionSocial.toInt(),
                            accesibilidad = accesibilidad.toInt(),
                            foto = fotosList
                        )

                        RetrofitClient.instance.createOpinion(newOpinion)
                            .enqueue(object : Callback<String> {
                                override fun onResponse(
                                    call: Call<String>,
                                    response: Response<String>
                                ) {
                                    if (response.isSuccessful) {
                                        Toast.makeText(
                                            context,
                                            R.string.text_sent_opinion,
                                            Toast.LENGTH_SHORT
                                        ).show()
                                    } else {
                                        Toast.makeText(
                                            context,
                                            R.string.error_send_opinion,
                                            Toast.LENGTH_SHORT
                                        ).show()
                                    }
                                }

                                override fun onFailure(call: Call<String>, t: Throwable) {
                                    Toast.makeText(
                                        context,
                                        "Fallo en la petición: ${t.message}",
                                        Toast.LENGTH_SHORT
                                    ).show()
                                }
                            })
                        onDismiss()
                    },
                    colors = ButtonDefaults.buttonColors(
                        backgroundColor = colorResource(R.color.green500),
                        contentColor = colorResource(R.color.white)
                    )
                ) {
                    Text(stringResource(id = R.string.send_opinion_button))
                }
            },
            dismissButton = {
                Button(
                    onClick = onDismiss,
                    colors = ButtonDefaults.buttonColors(
                        backgroundColor = colorResource(R.color.green500),
                        contentColor = colorResource(R.color.white)
                    )
                ) {
                    Text(stringResource(id = R.string.cancel_button))
                }
            }
        )
    }

}